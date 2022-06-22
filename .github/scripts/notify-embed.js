const getPlatforms = () => {
  const platforms = [];
  const {
    ENABLE_ANDROID,
    ENABLE_IOS,
    ENABLE_LINUX,
    ENABLE_MACOS,
    ENABLE_WEB,
    ENABLE_WINDOWS,
  } = process.env;

  if (ENABLE_ANDROID) platforms.push("Android");
  if (ENABLE_IOS) platforms.push("iOS");
  if (ENABLE_LINUX) platforms.push("Linux");
  if (ENABLE_MACOS) platforms.push("macOS");
  if (ENABLE_WEB) platforms.push("Web");
  if (ENABLE_WINDOWS) platforms.push("Windows");

  if (platforms.length) return platforms.join(", ");
  return "None";
};

const getChangelog = () => {
  if (process.env.CHANGELOG) return process.env.CHANGELOG;
  return "No Documented Changes";
};

const getRelease = () => {
  let url = "https://builds.lunasea.app";
  if (process.env.BUILD_TITLE) url += `/#${process.env.BUILD_TITLE}/`;
  return `[Download](${url})`;
};

const getWeb = () => {
  let url = "";
  if (process.env.FLAVOR !== "stable") url += `${process.env.FLAVOR}.`;
  url += "web.lunasea.app";
  return `[View Deployment](https://${url})`;
};

module.exports = () => {
  return JSON.stringify([
    {
      title: process.env.BUILD_TITLE ?? "Unknown Build",
      color: 5164195,
      timestamp: new Date().toISOString(),
      fields: [
        {
          name: "Release",
          value: getRelease(),
          inline: true,
        },
        {
          name: "Web",
          value: getWeb(),
          inline: true,
        },
        {
          name: "Platforms",
          value: getPlatforms(),
        },
        {
          name: "Changelog",
          value: getChangelog(),
        },
      ],
    },
  ]);
};
