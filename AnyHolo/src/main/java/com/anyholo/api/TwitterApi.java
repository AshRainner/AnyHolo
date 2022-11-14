package com.anyholo.api;

import java.io.File;
import java.io.IOException;

import com.fasterxml.jackson.core.exc.StreamReadException;
import com.fasterxml.jackson.databind.DatabindException;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.github.redouane59.twitter.TwitterClient;
import io.github.redouane59.twitter.signature.TwitterCredentials;

public class TwitterApi {
	final static String ACCESS_TOKEN = "하드 코딩용";
	final static String ACCESS_TOKEN_SECRET = "하드 코딩용";
	final static String API_KEY = "하드 코딩용";
	final static String API_KEY_SECRET = "하드 코딩용";
	/*static TwitterClient twitterClient = new TwitterClient(TwitterCredentials.builder()
			.accessToken(ACCESS_TOKEN)
			.accessTokenSecret(ACCESS_TOKEN_SECRET)
			.apiKey(API_KEY)
			.apiSecretKey(API_KEY_SECRET)
			.build());*///하드코딩용
	public static TwitterClient getTwitterClient() throws StreamReadException, DatabindException, IOException {
		TwitterClient twitterClient = new TwitterClient(
				new ObjectMapper().readValue(new File("/key/TwitterApiKey.json"),TwitterCredentials.class));//리눅스 용
		//파일 위치 적으면됨
		//TwitterClient twitterClient = new TwitterClient(
		//		new ObjectMapper().readValue(new File("C:\\Users\\User\\Desktop\\test\\TwitterApiKey.json"),TwitterCredentials.class));//윈도우 용 테스트
		return twitterClient;
	}
}
