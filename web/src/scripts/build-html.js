const fs = require('fs');
const path = require('path');
const { minify } = require('html-minifier-terser');

async function buildHtml() {
    const templateDir = 'src/templates';
    const files = fs.readdirSync(templateDir);

    if (!fs.existsSync('public')){
        fs.mkdirSync('public');
    }

    for (const file of files) {
        if (path.extname(file) === '.html') {
            const html = fs.readFileSync(path.join(templateDir, file), 'utf8');
            const minified = await minify(html, {
                collapseWhitespace: true,
                removeComments: true,
                minifyJS: true,
                minifyCSS: true
            });
            fs.writeFileSync(path.join('public', file), minified);
        }
    }
}

buildHtml().catch(console.error);