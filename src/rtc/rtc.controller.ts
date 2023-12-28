import { Controller, Get, Param } from '@nestjs/common';

import { ISampleResponse } from './interfaces';
import { RtcService } from './rtc.service';

@Controller('rtc')
export class RtcController {
  constructor(private readonly rtcService: RtcService) {}

  @Get('/room/:id')
  async checkIsRoomExist(
    @Param('id') roomId: string,
  ): Promise<ISampleResponse> {
    console.log('roomId', roomId);
    return this.rtcService.getSampleResponse();
  }
}
