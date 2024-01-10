import { Controller, Get, Param } from '@nestjs/common';

import { IGenerateResponse } from './interfaces';
import { RtcService } from './rtc.service';

@Controller('rtc')
export class RtcController {
  constructor(private readonly rtcService: RtcService) {}

  @Get('/health')
  checkHealth(): any {
    return {
      success: true,
    };
  }

  @Get('/room/:id')
  async checkIsRoomExist(
    @Param('id') roomId: string,
  ): Promise<IGenerateResponse> {
    const isRoomAvailable = await this.rtcService.checkRoomAvailability(roomId);
    if (!isRoomAvailable) {
      return this.rtcService.generateResponse(false, 'Room is not found');
    }

    return this.rtcService.generateResponse();
  }
}
