import {
  OnGatewayDisconnect,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';

import type { ICreateRoom, IJoinRoom } from './interfaces';
import { RtcService } from './rtc.service';

@WebSocketGateway(50052, {
  cors: {
    origin: '*',
  },
})
export class RtcGateway implements OnGatewayDisconnect {
  @WebSocketServer() server: Server;

  constructor(private readonly rtcService: RtcService) {}

  @SubscribeMessage('create-new-room')
  async handleCreateNewRoom(
    client: Socket,
    payload: ICreateRoom,
  ): Promise<void> {
    const socketRoom = await this.rtcService.createSocketRoom();
    await this.rtcService.insertSocketUser({
      name: payload.meetingName,
      roomId: socketRoom.roomId,
      socketId: client.id,
    });

    client.join(socketRoom.roomId);

    client.emit('room-id', {
      success: true,
      socketId: client.id,
      roomId: socketRoom.roomId,
    });

    const connectedUsers = await this.rtcService.queryUsersByRoomId(
      socketRoom.roomId,
    );

    client.emit('room-users', {
      connectedUsers,
    });
  }

  @SubscribeMessage('join-room')
  async handleJoinRoom(client: Socket, payload: IJoinRoom): Promise<void> {
    await this.rtcService.insertSocketUser({
      name: payload.meetingName,
      roomId: payload.meetingId,
      socketId: client.id,
    });

    client.join(payload.meetingId);

    client.emit('room-id', {
      success: true,
      socketId: client.id,
      roomId: payload.meetingId,
    });

    const connectedUsers = await this.rtcService.queryUsersByRoomId(
      payload.meetingId,
    );

    this.server.volatile.to(payload.meetingId).emit('room-users', {
      connectedUsers,
    });
  }

  async handleDisconnect(client: Socket): Promise<void> {
    const getUser = await this.rtcService.queryUserBySocketId(client.id);

    await this.rtcService.removeUserByUserId(getUser.userId);

    client.leave(getUser.roomId);

    const connectedUsers = await this.rtcService.queryUsersByRoomId(
      getUser.roomId,
    );

    this.server.volatile.to(getUser.roomId).emit('room-users', {
      connectedUsers,
    });
  }
}
