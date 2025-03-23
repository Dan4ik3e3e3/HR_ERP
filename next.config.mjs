/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  experimental: {
    swcPlugins: [
      ['next-swc-plugin', {}],
    ],
  },
}

export default nextConfig; 