import { Module } from '@nestjs/common';
import { RtcModule } from './rtc/rtc.module';

@Module({
  imports: [RtcModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
