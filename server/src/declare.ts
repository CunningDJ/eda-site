import express from 'express';
import expressSession from 'express-session';

interface User {
  id: string;
}

declare module "express-session" {
  interface SessionData {
    user: User;
  }
}
