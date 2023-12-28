import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { PrismaModule } from './prisma/prisma.module';
import { RtcModule } from './rtc/rtc.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    PrismaModule,
    RtcModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
