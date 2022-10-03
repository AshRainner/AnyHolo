package com.anyholo.model.live;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.processing.Generated;

import com.anyholo.model.profile.Thumbnails;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
	"publishedAt",
	"channelId",
	"title",
	"description",
	"thumbnails",
	"channelTitle",
	"categoryId",
	"liveBroadcastContent",
	"localized"
})
@Generated("jsonschema2pojo")
public class Snippet {

	@JsonProperty("publishedAt")
	private String publishedAt;
	@JsonProperty("channelId")
	private String channelId;
	@JsonProperty("title")
	private String title;
	@JsonProperty("description")
	private String description;
	@JsonProperty("thumbnails")
	private Thumbnails thumbnails;
	@JsonProperty("channelTitle")
	private String channelTitle;
	@JsonProperty("categoryId")
	private String categoryId;
	@JsonProperty("liveBroadcastContent")
	private String liveBroadcastContent;
	@JsonProperty("localized")
	private Localized localized;
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

	@JsonProperty("publishedAt")
	public String getPublishedAt() {
		return publishedAt;
	}

	@JsonProperty("publishedAt")
	public void setPublishedAt(String publishedAt) {
		this.publishedAt = publishedAt;
	}

	@JsonProperty("channelId")
	public String getChannelId() {
		return channelId;
	}

	@JsonProperty("channelId")
	public void setChannelId(String channelId) {
		this.channelId = channelId;
	}

	@JsonProperty("title")
	public String getTitle() {
		return title;
	}

	@JsonProperty("title")
	public void setTitle(String title) {
		this.title = title;
	}

	@JsonProperty("description")
	public String getDescription() {
		return description;
	}

	@JsonProperty("description")
	public void setDescription(String description) {
		this.description = description;
	}

	@JsonProperty("thumbnails")
	public Thumbnails getThumbnails() {
		return thumbnails;
	}

	@JsonProperty("thumbnails")
	public void setThumbnails(Thumbnails thumbnails) {
		this.thumbnails = thumbnails;
	}

	@JsonProperty("channelTitle")
	public String getChannelTitle() {
		return channelTitle;
	}

	@JsonProperty("channelTitle")
	public void setChannelTitle(String channelTitle) {
		this.channelTitle = channelTitle;
	}

	@JsonProperty("categoryId")
	public String getCategoryId() {
		return categoryId;
	}

	@JsonProperty("categoryId")
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	@JsonProperty("liveBroadcastContent")
	public String getLiveBroadcastContent() {
		return liveBroadcastContent;
	}

	@JsonProperty("liveBroadcastContent")
	public void setLiveBroadcastContent(String liveBroadcastContent) {
		this.liveBroadcastContent = liveBroadcastContent;
	}

	@JsonProperty("localized")
	public Localized getLocalized() {
		return localized;
	}

	@JsonProperty("localized")
	public void setLocalized(Localized localized) {
		this.localized = localized;
	}

	@JsonAnyGetter
	public Map<String, Object> getAdditionalProperties() {
		return this.additionalProperties;
	}

	@JsonAnySetter
	public void setAdditionalProperty(String name, Object value) {
		this.additionalProperties.put(name, value);
	}

}