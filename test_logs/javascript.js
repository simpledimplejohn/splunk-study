// this should generate logs
// first round, add to this as things go on
const fs = require('fs');
const filePath = './test_log.log'

let count = 59
let content = ""


// 01/18/2024 11:24:00.000 -0800 INFO Process = data_here Key=value thing=potato 
for(let i = 0; i < count; i ++) {
    content += `01/23/2024 10:${i}:00.000 -0800 INFO Process = test\n`
}



// writes to the file
fs.writeFile(filePath, content, (err) => {
    if (err) {
        console.error('Cant write to the path: ', err);
    } else {
        console.log('success')
    }
})