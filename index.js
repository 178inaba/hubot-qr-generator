const fs = require('fs');
const path = require('path');

module.exports = function(robot, scripts) {
  const scriptsPath = path.resolve(__dirname, 'src');
  fs.exists(scriptsPath, function(exists) {
    if (exists) {
      for (const script of fs.readdirSync(scriptsPath)) {
        if (scripts != null && !scripts.includes('*')) {
          if (scripts.includes(script)) {
            robot.loadFile(scriptsPath, script);
          }
        } else {
          robot.loadFile(scriptsPath, script);
        }
      }
    }
  });
};
