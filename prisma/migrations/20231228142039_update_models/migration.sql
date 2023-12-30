/*
  Warnings:

  - You are about to drop the `SocketRoom` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SocketUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "SocketUser" DROP CONSTRAINT "SocketUser_user_id_fkey";

-- DropTable
DROP TABLE "SocketRoom";

-- DropTable
DROP TABLE "SocketUser";

-- CreateTable
CREATE TABLE "socket_user" (
    "id" SERIAL NOT NULL,
    "user_id" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "socket_user_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "socket_room" (
    "id" SERIAL NOT NULL,
    "room_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "socket_room_pkey" PRIMARY KEY ("room_id")
);

-- AddForeignKey
ALTER TABLE "socket_user" ADD CONSTRAINT "socket_user_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "socket_room"("room_id") ON DELETE RESTRICT ON UPDATE CASCADE;
