module.exports = {
    branches: ['main'],
    plugins: [
      '@semantic-release/commit-analyzer', // determines type of release
      '@semantic-release/release-notes-generator',
      [
        '@semantic-release/changelog',
        {
          changelogFile: 'RELEASE_NOTES.md',
        },
      ],
      '@semantic-release/github',
      [
        '@semantic-release/git',
        {
          assets: ['RELEASE_NOTES.md'],
          message: 'chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}',
        },
      ],
    ],
  };