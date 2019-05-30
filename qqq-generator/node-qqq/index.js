const minimist = require('minimist')

module.exports = () => {

const args = minimist(process.argv.slice(2))
let cmd = args._[0] || 'help'
console.log(cmd)
console.log('ahsi');

switch (cmd) { 
case 'tail':
function tail() { 
  var redis = require("redis"),
    client = redis.createClient();
console.log('hi');

client.on("subscribe", function (channel, count) {
    console.log("a nice channel", "I am sending my last message.");
});

client.on("message", function (channel, event) {
  console.log(event)

});

client.subscribe("qqq::channel::event")

}

  tail();
break;

}
}

