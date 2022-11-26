const getRelease = () => {
  const title = process.env.BUILD_TITLE;
  let url = "https://builds.lunasea.app";
  if (title) url += `/#${title}/`;
  return `[Download](${url})`;
};

const getWeb = () => {
  const flavor = process.env.BUILD_FLAVOR;
  let url = "";
  if (flavor !== "stable") url += `${process.env.BUILD_FLAVOR}.`;
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
      ],
    },
  ]);
};
