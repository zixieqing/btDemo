const fs = require('fs');
const path = require('path');
const ExcelJS = require('exceljs');

const MAX_COLORGRADATION = 30; // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_COLORSET = 495;       // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ
const MAX_DARKBIT = 5;          // ãÆÖÇ?£¬?ÐÆËß??ï×?áóËÇ

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

        // ??ÙþËìÌ«ãÒ
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
        console.dir(this.ColorSet)

        return true;
    }

    readInt32(dataView, offset) {
        if (offset + 4 > dataView.byteLength) {
            throw new Error('Offset is outside the bounds of the DataView');
        }
        return dataView.getInt32(offset, true);
    }

    readUint16(dataView, offset) {
        if (offset + 2 > dataView.byteLength) {
            return 0; // ûäíºøØõó??
        }
        return dataView.getUint16(offset, true);
    }

    saveToJSON(outputDir) {
        // ?ÜÁ?õóÙÍ?ðíî¤
        if (!fs.existsSync(outputDir)){
            fs.mkdirSync(outputDir);
        }

        // ÜÁðí ColorSet
        const colorSetData = this.ColorSet.map((value, index) => ({
            key: index,
            value: Array.from(value)
        }));
        fs.writeFileSync(path.join(outputDir, 'ColorSet.json'), JSON.stringify(colorSetData, null, 2));

        // ÜÁðí GradationValue
        const gradationValueData = this.GradationValue.map((value, index) => ({
            key: index,
            value: value
        }));
        fs.writeFileSync(path.join(outputDir, 'GradationValue.json'), JSON.stringify(gradationValueData, null, 2));

        // ÜÁðí ColorSetDarkness
        const colorSetDarknessData = this.ColorSetDarkness.map((darknessSet, k) => ({
            darkBit: k,
            values: darknessSet.map((value, index) => ({
                key: index,
                value: Array.from(value)
            }))
        }));
        fs.writeFileSync(path.join(outputDir, 'ColorSetDarkness.json'), JSON.stringify(colorSetDarknessData, null, 2));

        console.log('Data saved to JSON files successfully.');
    }
    saveToCSV(outputDir) {
        // ?ÜÁ?õóÙÍ?ðíî¤
        if (!fs.existsSync(outputDir)){
            fs.mkdirSync(outputDir);
        }
    
        // ÜÁðí ColorSet
        const colorSetCSV = this.ColorSet.map((row) => Array.from(row).join(',')).join('\n');
        fs.writeFileSync(path.join(outputDir, 'ColorSet.csv'), colorSetCSV);
    
        // ÜÁðí GradationValue
        const gradationValueCSV = this.GradationValue.map(value => value).join('\n');
        fs.writeFileSync(path.join(outputDir, 'GradationValue.csv'), gradationValueCSV);
    
        // ÜÁðí ColorSetDarkness
        const colorSetDarknessCSV = this.ColorSetDarkness.map((darknessSet, k) => 
            darknessSet.map((row) => Array.from(row).join(',')).join('\n')
        ).join(`\n\n--- DarkBit ${k} ---\n\n`);
        fs.writeFileSync(path.join(outputDir, 'ColorSetDarkness.csv'), colorSetDarknessCSV);
    
        console.log('Data saved to CSV files successfully.');
    }
    getIndexColor(step, r0, g0, b0, r1, g1, b1) {
        const colors = []; // éÄéÍðí?ßæà÷îÜ?ßä

        const sr = (r1 - r0) / (step - 1);
        const sg = (g1 - g0) / (step - 1);
        const sb = (b1 - b0) / (step - 1);

        let r = r0;
        let g = g0;
        let b = b0;

        for (let i = 0; i < step; i++) {
            const red = Math.round(r);
            const green = Math.round(g);
            const blue = Math.round(b);

            // ÞÅéÄ CDirectDraw.Color Û°Ûö?ßæà÷?ßä?
            colors.push(this.color(red, green, blue));

            r += sr;
            g += sg;
            b += sb;
        }

        return colors; // Ú÷üÞßæà÷îÜ?ßä??
    }

    
}

// ÞÅéÄãÆÖÇ
const sprite = new CIndexSprite();
try {
    console.log("Index table loading...", path.join(__dirname, 'IndexTable555'));
    sprite.loadIndexTableFromFile(path.join(__dirname, 'IndexTable555'));
    console.log('Index table loaded successfully.');

    // ÜÁðí? JSON ÙþËì
    sprite.saveToCSV(path.join(__dirname, 'output2'));


	rgbPoint[MAX_COLORSET_SEED][3] = 
	{
		{ 0, 0, 31 },
		{ 0, 31, 0 },
		{ 31, 0, 0 },
		{ 0, 31, 31 },
		{ 31, 0, 31 },
		{ 31, 31, 0 },

		{ 0, 0, 16 },
		{ 0, 16, 0 },
		{ 16, 0, 0 },
		{ 0, 16, 16 },
		{ 16, 0, 16 },
		{ 16, 16, 0 },	

		{ 16, 31, 0 },
		{ 16, 0, 31 },
		{ 31, 16, 0 },
		{ 0, 16, 31 },
		{ 31, 0, 16 },
		{ 0, 31, 16 },

		{ 16, 31, 16 },
		{ 16, 16, 31 },
		{ 31, 16, 16 },

		{ 16, 31, 31 },
		{ 31, 16, 31 },
		{ 31, 31, 16 },

		{ 16, 16, 16 }, // È¸»ö
		{ 24, 24, 24 }, // ¹àÀº È¸»ö
		{ 8, 8, 8 }, // ¾îµÎ¿î È¸»ö		

		{ 30, 24, 18 }, // »ì»ö
		{ 25, 15, 11 },	// °¥»ö		
		{ 21, 12, 11 },				
		{ 19, 15, 13 }, // °íµ¿»ö				

		{ 21, 18, 11 }, // ¿¬ÇÑ »ì»ö		

		{ 22, 16, 9 } // »ì»ö		
	};


    sprite.getIndexColor(15, 31, 31, 31, )
} catch (error) {
    console.error(error.message);
}
