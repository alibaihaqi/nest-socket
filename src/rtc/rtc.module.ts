import { Module } from '@nestjs/common';
import { RtcGateway } from './rtc.gateway';

@Module({
  providers: [RtcGateway],
})
export class RtcModule {}
