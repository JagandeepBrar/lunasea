const platforms = () => {
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

const changelog = () => {
  return process.env.CHANGELOG ?? "No Documented Changes";
};

const web = () => {
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
          value: `[Download](https://builds.lunasea.app/#${process.env.BUILD_TITLE}/)`,
          inline: true,
        },
        {
          name: "Web",
          value: web(),
          inline: true,
        },
        {
          name: "Platforms",
          value: platforms(),
        },
        {
          name: "Changelog",
          value: changelog(),
        },
      ],
    },
  ]);
};
