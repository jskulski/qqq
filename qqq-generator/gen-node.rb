def define_cli(&content)
  <<-EOF
const minimist = require('minimist')

module.exports = () => {

const args = minimist(process.argv.slice(2))
let cmd = args._[0] || 'help'
console.log(cmd)
console.log('ahsi');

switch (cmd) { 
#{content.call}
}
}
  EOF
end

def define_command(command_name, &content)
  <<-EOF
case 'tail':
#{define_function(command_name) do
  content.call
end }
  #{command_name}();
break;
  EOF
end

def define_function(func_name, &content)
  <<-EOF
function #{func_name}() { 
#{content.call}
}
  EOF
end

def pubsub_subscribe(channel_name, &content)
  <<-EOF
  var redis = require("redis"),
    client = redis.createClient();
console.log('hi');

client.on("subscribe", function (channel, count) {
    console.log("a nice channel", "I am sending my last message.");
});

client.on("message", function (channel, event) {
#{content.call}
});

client.subscribe(#{channel_name})
  EOF
end

def print_command(&block)
  <<-EOF
  console.log(#{block.call})
  EOF
end

def human_format
  "event"
end

def run(code)
  puts
  puts "Generated: "
  puts
  puts code

  f = File.open("node-qqq/index.js", 'w')
  f.write(code)
  f.write("\n")
  f.close

  puts "run..."
  puts `node-qqq tail`
end
