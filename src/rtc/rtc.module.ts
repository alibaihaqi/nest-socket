import { Module } from '@nestjs/common';
import { RtcGateway } from './rtc.gateway';
import { RtcController } from './rtc.controller';
import { RtcService } from './rtc.service';

@Module({
  controllers: [RtcController],
  // RtcGateway is used for socket.io
  // RtcService is used for REST API
  providers: [RtcGateway, RtcService],
})
export class RtcModule {}
