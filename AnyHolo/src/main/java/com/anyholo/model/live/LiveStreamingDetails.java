package com.anyholo.model.live;

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
	"scheduledStartTime",
	"activeLiveChatId",
	"actualStartTime",
	"concurrentViewers"
})
@Generated("jsonschema2pojo")
public class LiveStreamingDetails {

	@JsonProperty("scheduledStartTime")
	private String scheduledStartTime;
	@JsonProperty("activeLiveChatId")
	private String activeLiveChatId;
	@JsonProperty("actualStartTime")
	private String actualStartTime;
	@JsonProperty("concurrentViewers")
	private String concurrentViewers;
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

	@JsonProperty("scheduledStartTime")
	public String getScheduledStartTime() {
		return scheduledStartTime;
	}

	@JsonProperty("scheduledStartTime")
	public void setScheduledStartTime(String scheduledStartTime) {
		this.scheduledStartTime = scheduledStartTime;
	}

	@JsonProperty("activeLiveChatId")
	public String getActiveLiveChatId() {
		return activeLiveChatId;
	}

	@JsonProperty("activeLiveChatId")
	public void setActiveLiveChatId(String activeLiveChatId) {
		this.activeLiveChatId = activeLiveChatId;
	}

	@JsonProperty("actualStartTime")
	public String getActualStartTime() {
		return actualStartTime;
	}

	@JsonProperty("actualStartTime")
	public void setActualStartTime(String actualStartTime) {
		this.actualStartTime = actualStartTime;
	}

	@JsonProperty("concurrentViewers")
	public String getConcurrentViewers() {
		return concurrentViewers;
	}

	@JsonProperty("concurrentViewers")
	public void setConcurrentViewers(String concurrentViewers) {
		this.concurrentViewers = concurrentViewers;
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