on:
  push:
    branches:
      - 'release/*'
      - 'develop'

    - name: Run semantic-release
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      run: |
        if [[ "${GITHUB_REF##*/}" == "develop" ]]; then
          npx semantic-release --tag nightly
        else
          npx semantic-release
        fi
