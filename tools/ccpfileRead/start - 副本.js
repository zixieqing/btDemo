const fs = require('fs');
const path = require('path')
const ExcelJS = require('exceljs');

const MAX_COLORGRADATION = 30; // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_COLORSET = 495;       // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_DARKBIT = 5;         // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ



class CIndexSprite {
    constructor() {
        this.ColorSet = Array.from({ length: MAX_COLORSET }, () => new Uint16Array(MAX_COLORGRADATION));
        this.GradationValue = new Uint16Array(MAX_COLORSET);
        this.ColorSetDarkness = Array.from({ length: MAX_DARKBIT }, () => Array.from({ length: MAX_COLORSET }, () => new Uint16Array(MAX_COLORGRADATION)));
    }

    loadIndexTableFromFile(filePath) {
        const fileBuffer = fs.readFileSync(filePath);
        const arrayBuffer = fileBuffer.buffer.slice(fileBuffer.byteOffset, fileBuffer.byteOffset + fileBuffer.byteLength);
        const dataView = new DataView(arrayBuffer);

        let offset = 0;

        // ?ö¢???í®
        const cg = this.readInt32(dataView, offset);
        offset += 4;
        const cs = this.readInt32(dataView, offset);
        offset += 4;
        const db = this.readInt32(dataView, offset);
        offset += 4;

        if (cg !== MAX_COLORGRADATION || cs !== MAX_COLORSET || db !== MAX_DARKBIT) {
            // throw new Error('File validation failed');
        }

        // ?ö¢ ColorSet
        for (let i = 0; i < MAX_COLORSET; i++) {
            for (let j = 0; j < MAX_COLORGRADATION; j++) {
                this.ColorSet[i][j] = this.readUint16(dataView, offset);
                offset += 2;
            }
        }

        // ?ö¢ GradationValue
        for (let i = 0; i < MAX_COLORSET; i++) {
            this.GradationValue[i] = this.readUint16(dataView, offset);
            offset += 2;
        }

        // ?ö¢ ColorSetDarkness
        for (let k = 0; k < MAX_DARKBIT; k++) {
            for (let i = 0; i < MAX_COLORSET; i++) {
                for (let j = 0; j < MAX_COLORGRADATION; j++) {
                    this.ColorSetDarkness[k][i][j] = this.readUint16(dataView, offset);
                    offset += 2;
                }
            }
        }

        return true;
    }

    readInt32(dataView, offset) {
        if (offset + 4 > dataView.byteLength) {
            throw new Error('Offset is outside the bounds of the DataView1');
        }
        return dataView.getInt32(offset, true);
    }

    readUint16(dataView, offset) {
        if (offset + 2 > dataView.byteLength) {
            // throw new Error('Offset is outside the bounds of the DataView2');
            return 0;
        }
        return dataView.getUint16(offset, true);
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
