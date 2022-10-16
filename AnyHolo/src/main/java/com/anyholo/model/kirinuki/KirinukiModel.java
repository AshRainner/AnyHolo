package com.anyholo.model.kirinuki;

import java.util.HashMap;
import java.util.List;
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
	"kind",
	"etag",
	"nextPageToken",
	"prevPageToken",
	"items",
	"pageInfo"
})
@Generated("jsonschema2pojo")
public class KirinukiModel {

	@JsonProperty("kind")
	private String kind;
	@JsonProperty("etag")
	private String etag;
	@JsonProperty("nextPageToken")
	private String nextPageToken;
	@JsonProperty("prevPageToken")
	private String prevPageToken;
	@JsonProperty("items")
	private List<Item> items = null;
	@JsonProperty("pageInfo")
	private PageInfo pageInfo;
	@JsonIgnore
	private Map<String, Object> additionalProperties = new HashMap<String, Object>();

	@JsonProperty("kind")
	public String getKind() {
		return kind;
	}

	@JsonProperty("kind")
	public void setKind(String kind) {
		this.kind = kind;
	}

	@JsonProperty("etag")
	public String getEtag() {
		return etag;
	}

	@JsonProperty("etag")
	public void setEtag(String etag) {
		this.etag = etag;
	}

	@JsonProperty("nextPageToken")
	public String getNextPageToken() {
		return nextPageToken;
	}

	@JsonProperty("nextPageToken")
	public void setNextPageToken(String nextPageToken) {
		this.nextPageToken = nextPageToken;
	}

	@JsonProperty("prevPageToken")
	public String getPrevPageToken() {
		return prevPageToken;
	}

	@JsonProperty("prevPageToken")
	public void setPrevPageToken(String prevPageToken) {
		this.prevPageToken = prevPageToken;
	}

	@JsonProperty("items")
	public List<Item> getItems() {
		return items;
	}

	@JsonProperty("items")
	public void setItems(List<Item> items) {
		this.items = items;
	}

	@JsonProperty("pageInfo")
	public PageInfo getPageInfo() {
		return pageInfo;
	}

	@JsonProperty("pageInfo")
	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
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