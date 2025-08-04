import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { PrismaService } from 'src/prisma/prisma.service';
import { RoleService } from './role/role.service';

@Module({
  controllers: [UsersController],
  providers: [UsersService, PrismaService, RoleService],
})
export class UsersModule {}
