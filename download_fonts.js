const https = require('https');
const fs = require('fs');
const path = require('path');

// Font variants to download
const fontVariants = [
  { weight: 400, style: 'normal', filename: 'Jost-Regular.ttf' },
  { weight: 500, style: 'normal', filename: 'Jost-Medium.ttf' },
  { weight: 600, style: 'normal', filename: 'Jost-SemiBold.ttf' },
  { weight: 700, style: 'normal', filename: 'Jost-Bold.ttf' }
];

// Create temp directory if it doesn't exist
const tempDir = path.join(__dirname, 'temp_fonts');
if (!fs.existsSync(tempDir)) {
  fs.mkdirSync(tempDir, { recursive: true });
}

// Download each font variant
fontVariants.forEach(variant => {
  const url = `https://fonts.gstatic.com/s/jost/v15/92zPtBhPNqw79Ij1E865zBUv7myjJTVBNI4.ttf`;
  const filePath = path.join(tempDir, variant.filename);
  
  console.log(`Downloading ${variant.filename}...`);
  
  const file = fs.createWriteStream(filePath);
  https.get(url, response => {
    response.pipe(file);
    file.on('finish', () => {
      file.close();
      console.log(`Downloaded ${variant.filename}`);
    });
  }).on('error', err => {
    fs.unlink(filePath);
    console.error(`Error downloading ${variant.filename}: ${err.message}`);
  });
});

console.log('Font download script started. Please wait for all downloads to complete.');
