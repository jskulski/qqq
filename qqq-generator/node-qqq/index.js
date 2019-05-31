const minimist = require('minimist')

module.exports = () => {

const args = minimist(process.argv.slice(2))
let cmd = args._[0] || 'help'
console.log(cmd)
console.log('ahsi');

switch (cmd) { 
case 'mark':
function mark() { 
var redis = require("redis"),
    client = redis.createClient();

    client.publish("qqq::channel::event",   JSON.stringify({
  'uuid': '123',
  'timestamp': 'now',
  'message': "--MARK--"
}
)
)
client.quit();

}

  mark();
break;

}
}

