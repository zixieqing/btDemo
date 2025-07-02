const fs = require('fs');
const path = require('path')

const MAX_COLORGRADATION = 30; // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_COLORSET = 495;       // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_DARKBIT = 5;         // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ

// #define	MAX_COLORSET_SEED			33	// ±âº» »ö»óÀÇ °³¼ö
// #define	MAX_COLORSET_SEED_MODIFY	15	// ±âº» »ö»ó¸¶´ÙÀÇ º¯Çü »ö±ò ¼ö
// #define	MAX_COLORSET				495 // MAX_COLORSET_SEED * MAX_COLORSET_SEED_MODIFY
// #define	MAX_COLORGRADATION			30
// #define	MAX_COLOR_TO_GRADATION		93	// R+G+B
// #define	MAX_COLORGRADATION_HALF		15	// == MAX_COLORSET_SEED_MODIFY
// #define	MAX_DARKBIT					5

class CIndexSprite {
    constructor() {
        this.ColorSet = Array.from({ length: MAX_COLORSET }, () => new Uint16Array(MAX_COLORGRADATION));
        this.GradationValue = new Uint16Array(MAX_COLORSET);
        this.ColorSetDarkness = Array.from({ length: MAX_DARKBIT }, () => Array.from({ length: MAX_COLORSET }, () => new Uint16Array(MAX_COLORGRADATION)));
    }

    loadIndexTableFromFile(filePath) {
        const fileBuffer = fs.readFileSync(filePath);
        const arrayBuffer = fileBuffer.buffer.slice(fileBuffer.byteOffset, fileBuffer.byteOffset + fileBuffer.byteLength);
        // console.log("jlsjfsf",arrayBuffer)
        const dataView = new DataView(arrayBuffer);

        let offset = 0;

        // ?ö¢???í®
        const cg = dataView.getInt32(offset, true);
        offset += 4;
        const cs = dataView.getInt32(offset, true);
        offset += 4;
        const db = dataView.getInt32(offset, true);
        offset += 4;

        if (cg !== MAX_COLORGRADATION || cs !== MAX_COLORSET || db !== MAX_DARKBIT) {
            //throw new Error('File validation failed');
        }

        // ?ö¢ ColorSet
        for (let i = 0; i < MAX_COLORSET; i++) {
            for (let j = 0; j < MAX_COLORGRADATION; j++) {
                
                this.ColorSet[i][j] = dataView.getUint16(offset, true);
                console.log(this.ColorSet[i][j])
                offset += 2;
            }
        }

        // ?ö¢ GradationValue
        for (let i = 0; i < MAX_COLORSET; i++) {
            this.GradationValue[i] = dataView.getUint16(offset, true);
            console.log(this.GradationValue[i])

            offset += 2;
        }

        // ?ö¢ ColorSetDarkness
        for (let k = 0; k < MAX_DARKBIT; k++) {
            for (let i = 0; i < MAX_COLORSET; i++) {
                for (let j = 0; j < MAX_COLORGRADATION; j++) {
                    this.ColorSetDarkness[k][i][j] = dataView.getUint16(offset, true);
                    console.log(this.ColorSetDarkness[k][i][j])
                    offset += 2;
                }
            }
        }

        return true;
    }
}

// ÞÅéÄãÆÖÇ
const sprite = new CIndexSprite();
try {
    console.log("Index table loading...",path.join(__dirname,'IndexTable555'));
    sprite.loadIndexTableFromFile(path.join(__dirname,'IndexTable555'));
    console.log('Index table loaded successfully.');
} catch (error) {
    console.error(error.message);
}
