/*
  Warnings:

  - The primary key for the `SocketRoom` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `SocketRoom` table. All the data in the column will be lost.
  - You are about to drop the column `roomId` on the `SocketRoom` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `SocketRoom` table. All the data in the column will be lost.
  - The primary key for the `SocketUser` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `SocketUser` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `SocketUser` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `SocketUser` table. All the data in the column will be lost.
  - The required column `room_id` was added to the `SocketRoom` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `updated_at` to the `SocketRoom` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `SocketUser` table without a default value. This is not possible if the table is not empty.
  - The required column `user_id` was added to the `SocketUser` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- DropForeignKey
ALTER TABLE "SocketUser" DROP CONSTRAINT "SocketUser_userId_fkey";

-- AlterTable
ALTER TABLE "SocketRoom" DROP CONSTRAINT "SocketRoom_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "roomId",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "room_id" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD CONSTRAINT "SocketRoom_pkey" PRIMARY KEY ("room_id");

-- AlterTable
ALTER TABLE "SocketUser" DROP CONSTRAINT "SocketUser_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "updatedAt",
DROP COLUMN "userId",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "user_id" TEXT NOT NULL,
ADD CONSTRAINT "SocketUser_pkey" PRIMARY KEY ("user_id");

-- AddForeignKey
ALTER TABLE "SocketUser" ADD CONSTRAINT "SocketUser_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "SocketRoom"("room_id") ON DELETE RESTRICT ON UPDATE CASCADE;
