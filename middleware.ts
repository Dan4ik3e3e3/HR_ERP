import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';
import Logger from '@/utils/logger';

// Список разрешенных источников
const allowedOrigins = [
  'https://hr-erp.ru',
  'https://api.hr-erp.ru',
  'https://admin.hr-erp.ru'
];

// Список защищенных маршрутов, требующих аутентификации
const protectedRoutes = [
  '/api/candidates',
  '/api/documents',
  '/api/users',
];

export function middleware(request: NextRequest) {
  const response = NextResponse.next();
  const origin = request.headers.get('origin');
  const path = request.nextUrl.pathname;

  Logger.debug('Incoming request', {
    method: request.method,
    path,
    origin: origin || undefined,
    userAgent: request.headers.get('user-agent') || undefined
  });

  // CORS headers
  if (origin) {
    if (allowedOrigins.includes(origin) || process.env.NODE_ENV === 'development') {
      response.headers.set('Access-Control-Allow-Origin', origin);
      response.headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
      response.headers.set('Access-Control-Allow-Headers', 'Content-Type, Authorization');
      response.headers.set('Access-Control-Allow-Credentials', 'true');
      Logger.debug('CORS headers set', { origin });
    } else {
      Logger.warn('Blocked request from unauthorized origin', { origin });
    }
  }

  // Security headers
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin');
  response.headers.set(
    'Content-Security-Policy',
    "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';"
  );

  // Проверка аутентификации для защищенных маршрутов
  if (protectedRoutes.some(route => path.startsWith(route))) {
    const token = request.headers.get('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      Logger.warn('Unauthorized access attempt', { path });
      return new NextResponse(
        JSON.stringify({ message: 'Unauthorized' }),
        {
          status: 401,
          headers: {
            'Content-Type': 'application/json',
          },
        }
      );
    }
    
    Logger.debug('Authorized request', { path });
  }

  return response;
}

export const config = {
  matcher: [
    '/api/:path*',
    '/((?!_next/static|_next/image|favicon.ico).*)',
  ],
}; 