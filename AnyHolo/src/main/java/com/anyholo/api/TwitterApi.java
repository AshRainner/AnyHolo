package com.anyholo.api;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.anyholo.model.data.Tweet;

import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.dto.endpoints.AdditionalParameters;
import io.github.redouane59.twitter.dto.tweet.TweetList;
import io.github.redouane59.twitter.dto.tweet.TweetType;
import io.github.redouane59.twitter.dto.tweet.TweetV2.TweetData;
import io.github.redouane59.twitter.signature.TwitterCredentials;

public class TwitterApi {
	final static String ACCESS_TOKEN = "808300835000094721-qxnXYKulsArpmrnd8uTn1eVhF4cNyfU";
	final static String ACCESS_TOKEN_SECRET = "LjKFqRS1RuuZWo97Q7hSi7dj8KXBZD1vjgWoiSuNMw5km";
	final static String API_KEY = "4hnZ9ldS375R0DBGtaHQggjTR";
	final static String API_KEY_SECRET = "AWMFuB1jzFbNgwbWjBgXEIB1lISBB43irhnY69P2Awz9QDrfUi";
	static TwitterClient twitterClient = new TwitterClient(TwitterCredentials.builder()
			.accessToken(ACCESS_TOKEN)
			.accessTokenSecret(ACCESS_TOKEN_SECRET)
			.apiKey(API_KEY)
			.apiSecretKey(API_KEY_SECRET)
			.build());
	public static TwitterClient getTwitterClient() {
		return twitterClient;
	}
}
