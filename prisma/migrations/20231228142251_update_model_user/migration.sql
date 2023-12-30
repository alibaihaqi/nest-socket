/*
  Warnings:

  - Added the required column `roomId` to the `socket_user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "socket_user" DROP CONSTRAINT "socket_user_user_id_fkey";

-- AlterTable
ALTER TABLE "socket_user" ADD COLUMN     "roomId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "socket_user" ADD CONSTRAINT "socket_user_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "socket_room"("room_id") ON DELETE RESTRICT ON UPDATE CASCADE;
