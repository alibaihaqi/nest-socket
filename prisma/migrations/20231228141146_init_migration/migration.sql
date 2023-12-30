-- CreateTable
CREATE TABLE "SocketUser" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "name" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SocketUser_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "SocketRoom" (
    "id" SERIAL NOT NULL,
    "roomId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "SocketRoom_pkey" PRIMARY KEY ("roomId")
);

-- AddForeignKey
ALTER TABLE "SocketUser" ADD CONSTRAINT "SocketUser_userId_fkey" FOREIGN KEY ("userId") REFERENCES "SocketRoom"("roomId") ON DELETE RESTRICT ON UPDATE CASCADE;
