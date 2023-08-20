const fs = require("fs");
const path = require("path");

const contractsDirPath = "./contracts"
const contractFileNames = fs.readdirSync(contractsDirPath);

for (const fileName of contractFileNames) {
    console.log(`Migrating ${fileName}`)
    migrateContractSource(path.join(contractsDirPath, fileName))
}

function migrateContractSource(filePath) {
    const source = fs.readFileSync(filePath).toString("utf-8");

    const migratedSource = source.split("\n").map(line => {
        const isImportStatement = line.startsWith("import");
        if (isImportStatement) {
            const [_, contractName] = line.split(" ");
            return `import "${contractName}"`
        } else {
            return line;
        }
    }).join("\n");

    fs.writeFileSync(filePath, migratedSource)
}

