// Learn more https://docs.expo.dev/guides/customizing-metro
const { getDefaultConfig } = require('expo/metro-config');
const path = require('path');

// Get the default Expo Metro configuration
const config = getDefaultConfig(__dirname);

// Ensure the project root is watched
config.watchFolders = [__dirname];

// Optional: Explicitly tell Metro where assets are, although assetBundlePatterns in app.json should cover this.
// config.resolver.assetExts.push('cjs'); // Example if needed for specific extensions
// config.server.enhanceMiddleware = (middleware) => { // Example middleware enhancement
//   return (req, res, next) => {
//     // custom logic here
//     return middleware(req, res, next);
//   };
// };

module.exports = config;
