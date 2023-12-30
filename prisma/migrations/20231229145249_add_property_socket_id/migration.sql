/*
  Warnings:

  - Added the required column `socket_id` to the `socket_user` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "socket_user" ADD COLUMN     "socket_id" TEXT NOT NULL;
