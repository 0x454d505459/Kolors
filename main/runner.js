const dbus = require("dbus-native");
var exec = require("child_process").exec;
var path = require("path");
const { createKRunnerInterface } = require("./dbus-connection");

const sessionBus = dbus.sessionBus();
if (!sessionBus) throw new Error("Failed to connect to the session bus");

const $ = (cmd) => path.resolve(__dirname, `scripts/${cmd}`);
const execAsync = (cmd, ...args) => {
  return new Promise((resolve, reject) => {
    exec(
      `${cmd} ${args.map((arg) => `'${arg}'`).join(" ")}`,
      (error, stdout, stderr) => {
        !(stderr || error)
          ? resolve(stdout)
          : reject(new Error(`${stderr} ${error}`));
      }
    );
  });
};

createKRunnerInterface({
  path: "/kolors",
  async runFunction(matchID, actionID) {
    await execAsync($("copy_clipboard.sh"), matchID);
  },
  async matchFunction(query) {
    let color,
      args = [];
    const rgbRegex = /^(rgb|hsl|lch)\s*\(.*\)/
    color = rgbRegex.test(query) ? `${query.split(/\)/)[0]})` : query.split(" ")[0]
    
    try {
      await execAsync($("format_color.sh"), color);
    } catch {
      throw new Error("Invalid color was passed in.");
    } finally {
      args = query.replace(color, "").split(" ").slice(1).
      map(arg => (arg === "+") ? "mix" : arg)
      if (args.length)
        color = await execAsync($("adjust_color.sh"), color, ...args);
    }
    const formattedColor = await execAsync($("format_color.sh"), color)
    const thumbnail = await execAsync($("generate_thumbnail.sh"), formattedColor);
    const output = await execAsync($("print_info.sh"), formattedColor);
    return output
      .split("\n")
      .slice(0, -1)
      .map((e) => [e, e, thumbnail, 50, 0, {}]);
  },
});
