package com.anyholo.model.kirinuki;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Generated;
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
	"playlistId",
	"position",
	"resourceId",
	"videoOwnerChannelTitle",
	"videoOwnerChannelId"
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
	@JsonProperty("playlistId")
	private String playlistId;
	@JsonProperty("position")
	private Integer position;
	@JsonProperty("resourceId")
	private ResourceId resourceId;
	@JsonProperty("videoOwnerChannelTitle")
	private String videoOwnerChannelTitle;
	@JsonProperty("videoOwnerChannelId")
	private String videoOwnerChannelId;
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

	@JsonProperty("playlistId")
	public String getPlaylistId() {
		return playlistId;
	}

	@JsonProperty("playlistId")
	public void setPlaylistId(String playlistId) {
		this.playlistId = playlistId;
	}

	@JsonProperty("position")
	public Integer getPosition() {
		return position;
	}

	@JsonProperty("position")
	public void setPosition(Integer position) {
		this.position = position;
	}

	@JsonProperty("resourceId")
	public ResourceId getResourceId() {
		return resourceId;
	}

	@JsonProperty("resourceId")
	public void setResourceId(ResourceId resourceId) {
		this.resourceId = resourceId;
	}

	@JsonProperty("videoOwnerChannelTitle")
	public String getVideoOwnerChannelTitle() {
		return videoOwnerChannelTitle;
	}

	@JsonProperty("videoOwnerChannelTitle")
	public void setVideoOwnerChannelTitle(String videoOwnerChannelTitle) {
		this.videoOwnerChannelTitle = videoOwnerChannelTitle;
	}

	@JsonProperty("videoOwnerChannelId")
	public String getVideoOwnerChannelId() {
		return videoOwnerChannelId;
	}

	@JsonProperty("videoOwnerChannelId")
	public void setVideoOwnerChannelId(String videoOwnerChannelId) {
		this.videoOwnerChannelId = videoOwnerChannelId;
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