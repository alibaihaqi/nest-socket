import { Injectable } from '@nestjs/common';

import { IGenerateResponse, IUser } from './interfaces';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class RtcService {
  constructor(private prisma: PrismaService) {}

  createSocketRoom() {
    return this.prisma['socket_room'].create({
      data: {
        isActive: true,
      },
      select: {
        roomId: true,
        createdAt: true,
        isActive: true,
      },
    });
  }

  insertSocketUser(createUser: IUser) {
    return this.prisma['socket_user'].create({
      data: {
        name: createUser.name,
        roomId: createUser.roomId,
        socketId: createUser.socketId,
        isHostRoom: createUser.isHostRoom,
      },
      select: {
        roomId: true,
        createdAt: true,
      },
    });
  }

  queryUserBySocketId(socketId: string) {
    return this.prisma['socket_user'].findFirst({
      where: {
        socketId,
      },
      select: {
        userId: true,
        roomId: true,
        socketId: true,
        name: true,
      },
    });
  }

  removeUserByUserId(socketId: string) {
    return this.prisma['socket_user'].delete({
      where: {
        userId: socketId,
      },
      select: {
        roomId: true,
        socketId: true,
        name: true,
      },
    });
  }

  queryUsersByRoomId(roomId: string) {
    return this.prisma['socket_user'].findMany({
      where: {
        roomId: roomId,
      },
      select: {
        userId: true,
        name: true,
        socketId: true,
      },
    });
  }

  generateResponse(
    success: boolean = true,
    message: string = '',
  ): IGenerateResponse {
    return {
      success,
      message,
    };
  }

  async checkRoomAvailability(roomId: string): Promise<any> {
    return this.prisma['socket_room'].findFirst({
      where: {
        roomId: roomId,
      },
      select: {
        roomId: true,
        isActive: true,
      },
    });
  }
}
