module Paths_Rainfall (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,0,1], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/zpconn/Library/Haskell/ghc-7.4.1/lib/Rainfall-0.0.1/bin"
libdir     = "/Users/zpconn/Library/Haskell/ghc-7.4.1/lib/Rainfall-0.0.1/lib"
datadir    = "/Users/zpconn/Library/Haskell/ghc-7.4.1/lib/Rainfall-0.0.1/share"
libexecdir = "/Users/zpconn/Library/Haskell/ghc-7.4.1/lib/Rainfall-0.0.1/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "Rainfall_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Rainfall_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "Rainfall_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Rainfall_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
