const fs = require("fs");
const path = require("path");

const contractsDirPath = process.argv[2];

migrateFromRootDir(contractsDirPath)

function migrateFromRootDir(rootDirPath) {
    console.log(`Migrating imports in dir: ${rootDirPath}`)
    const fileOrDirNames = fs.readdirSync(rootDirPath);

    for (const fileOrDirName of fileOrDirNames) {
        const fileOrDirPath = path.join(rootDirPath, fileOrDirName);
        if (fs.statSync(fileOrDirPath).isFile()) {
            console.log(`Migrating ${fileOrDirName}`)
            migrateContractSource(fileOrDirPath)
        } else {
            migrateFromRootDir(fileOrDirPath)
        }
    }
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

