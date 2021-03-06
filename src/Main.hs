{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative
import           Snap.Core
import           Snap.Util.FileServe
import           Snap.Http.Server
import           System.Posix.Process
import           System.Posix.Signals
import           System.Posix.Types
import           System.Process
import           System.IO
import           Control.Applicative
import           Control.Monad.Trans
import           Control.Monad
import qualified Data.ByteString.Char8 as C

main :: IO ()
main = quickHttpServe site

site :: Snap ()
site =
    ifTop (runGitPull)


runGitPull :: Snap()
runGitPull = do
    (inn, out, err, idd) <- liftIO $ runInteractiveCommand $ "git pull"
    err_str <- liftIO $ hGetContents err
    out_str <- liftIO $ hGetContents out
    writeBS $ C.pack $ err_str ++ out_str



