{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedLists #-}

----------------------------------------------------------------------
-- |
-- Module: Web.Slack.User
-- Description:
--
--
--
----------------------------------------------------------------------

module Web.Slack.User
  ( Profile(..)
  , User(..)
  , ListRsp(..)
  , Email(..)
  )
  where

-- aeson
import Data.Aeson.TH

-- base
import GHC.Generics (Generic)

-- slack-web
import Web.Slack.Common
import Web.Slack.Util

-- text
import Data.Text (Text)

-- time
import Data.Time.Clock.POSIX

-- http-api-data
import Web.HttpApiData
import Web.FormUrlEncoded

-- See https://api.slack.com/types/user

data Profile = 
  Profile 
    { profileAvatarHash :: Maybe Text
    , profileStatusText :: Maybe Text
    , profileStatusEmoji :: Maybe Text 
    , profileRealName :: Maybe Text 
    , profileDisplayName :: Maybe Text 
    , profileRealNameNormalized :: Maybe Text 
    , profileDisplayNameNormalized :: Maybe Text 
    , profileEmail :: Maybe Text 
    , profileImage24 :: Text 
    , profileImage32 :: Text 
    , profileImage48 :: Text 
    , profileImage72 :: Text 
    , profileImage192 :: Text 
    , profileImage512 :: Text 
    , profileTeam :: Maybe Text 
    }
  deriving (Eq, Generic, Show)

$(deriveFromJSON (jsonOpts "profile") ''Profile)

data User =
  User
    { userId :: UserId
    , userName :: Text
    , userDeleted :: Bool
    , userColor :: Maybe Color
    , userProfile :: Maybe Profile
    , userIsAdmin :: Maybe Bool
    , userIsOwner :: Maybe Bool
    , userIsPrimaryOwner :: Maybe Bool
    , userIsRestricted :: Maybe Bool
    , userIsUltraRestricted :: Maybe Bool
    , userUpdated :: POSIXTime
    }
  deriving (Eq, Generic, Show)

$(deriveFromJSON (jsonOpts "user") ''User)

data ListRsp =
  ListRsp
    { listRspMembers :: [User]
    }
  deriving (Eq, Generic, Show)

$(deriveFromJSON (jsonOpts "listRsp") ''ListRsp)

newtype Email = Email Text deriving (Eq, Generic, Show)
instance ToForm Email where 
  toForm (Email txt) = [("email", toQueryParam txt)]

