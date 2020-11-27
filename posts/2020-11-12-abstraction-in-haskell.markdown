---
title: Abstraction in Haskell
draft: true
---

> Disclaimer: I am by no means a Haskell expert, so I could be making mistakes, and please [correct me](https://github.com/jeffhappily/jeffhappily.github.io/edit/develop/posts/2020-11-12-abstraction-in-haskell.html) if I do.

I came across this [issue](https://github.com/commercialhaskell/stack/issues/5422) of Stack on GitHub recently regarding Stack defaults to `master` branch while fetching a template, so it's failing when someone uses other branch names as their default branch, eg. `main`. To give you a better context, in Stack, there's a template feature where you can provide a predefined template when initializing a project, and it will scaffold a project based on your template, for example

```haskell
stack new my-project yesodweb/sqlite
```

Stack will try to fetch the template from the default repo service, which is GitHub. By using the `urlFromRepoTemplatePath` function, it generates the URL of the template and fetches the template from it, the generated URL from the example above will be something like this [https://raw.githubusercontent.com/yesodweb/stack-templates/master/sqlite.hsfiles](https://raw.githubusercontent.com/yesodweb/stack-templates/master/sqlite.hsfiles).

Everything seems to be working well until GitHub announced to change their default branch from `master` to `main`. At the time of writing the code, `master` has always been the default branch name for `Git`, so it's been hardcoded into the `urlFromRepoTemplatePath` function and this causes fetching templates from repositories that the default branch is `main` to fail.

```haskell
-- | Construct a URL for downloading from a repo.
urlFromRepoTemplatePath :: RepoTemplatePath -> Text
urlFromRepoTemplatePath (RepoTemplatePath Github user name) =
    T.concat ["https://raw.githubusercontent.com", "/", user, "/stack-templates/master/", name]
urlFromRepoTemplatePath (RepoTemplatePath Gitlab user name) =
    T.concat ["https://gitlab.com",                "/", user, "/stack-templates/raw/master/", name]
urlFromRepoTemplatePath (RepoTemplatePath Bitbucket user name) =
    T.concat ["https://bitbucket.org",             "/", user, "/stack-templates/raw/master/", name]
```

## Level 1

To resolve this issue, I proposed a [solution](https://github.com/commercialhaskell/stack/issues/5422#issuecomment-725065683) by using the API provided by the repo services to directly fetch the file from the default branch. This seems like a feasible solution, but how can we implement it?

```haskell
data RepoTemplatePath = RepoTemplatePath
    { rtpService  :: RepoService
    , rtpUser     :: Text
    , rtpTemplate :: Text
    }
    deriving (Eq, Ord, Show)

data RepoService = Github | Gitlab | Bitbucket
    deriving (Eq, Ord, Show)
```

As you can see from the type signature, there are 3 repo services, that means we'll have to fetch the data from 3 different API and get 3 different response type. The function should look something like this

```haskell
fetchFromRepoTemplatePath :: RepoTemplatePath -> IO a
```

but what should the `a` be?

Let's try using a sum type for the response since the `RepoService` is also a sum type.

```haskell
data GithubResponse
data GitlabResponse
data BitbucketResponse

data RepoServiceResponse
    = ResponseGithub GithubResponse
    | ResponseGitlab GitlabResponse
    | ResponseBitbucket BitbucketResponse

fetchFromRepoTemplatePath :: RepoTemplatePath -> IO RepoServiceResponse
```

This solution seems neat doesn't it? Unforfunately, although this seems to be type safe, it is actually not.

One thing you can do is to ignore the return type of the API and return the content of the file directly. That way, you can implement the functions individually and just return the same type for every case.

```haskell
fetchFromRepoTemplatePath :: RepoTemplatePath -> IO ByteString
```
