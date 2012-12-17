package com.company.util;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * Tree 형태로 데이터를 컨트롤하기 위한 객체
 * @author 9010661(지익호)
 *
 */
@SuppressWarnings("rawtypes")
public class TreeMap  {

	/**
	 * 실제 데이터가 들어가가는 Map
	 */
	private HashMap hashMap;
	
	/**
	 * 객체 초기화
	 */
	public TreeMap() {
		hashMap = new HashMap();
	}
	@SuppressWarnings("unchecked")
	public TreeMap(Map map) {
		hashMap = new HashMap(map);
	}
	
	public void clear() {
		hashMap.clear();
	}

	
	public boolean containsKey(Object... keys) {
		return search((keys.length -1) , keys).containsKey(keys[keys.length-1]);
	}

	public boolean containsValue(Object value , Object... keys) {
		return search((keys.length) , keys).containsValue(value);
	}

	public Set entrySet(Object... keys) {
		return search((keys.length) , keys).entrySet();
	}
	
	public HashMap toHashMap(){
		return hashMap;
	}
	@SuppressWarnings("unchecked")
	private HashMap search(long l , Object... keys){
		HashMap h = null , h2;
		h2 = hashMap;
		for (int i = 0; i < l ; i++) {
			h = (HashMap) h2.get(keys[i]);
			if(h == null){
				h = new HashMap();
				h2.put(keys[i], h);
			}
			h2 = h;
		}
		return h2;
	}

	public Object get(Object... keys ) {
		return search((keys.length -1) , keys).get(keys[keys.length -1]);
	}

	public boolean isEmpty(Object... keys) {
		return search((keys.length -1),keys).isEmpty();
	}

	public Set keySet(Object... keys) {
		return search((keys.length) , keys).keySet();
	}

	@SuppressWarnings("unchecked")
	public Object put(Object value , Object... keys) {
		return search((keys.length -1) , keys).put(keys[keys.length-1], value);
	}

	@SuppressWarnings("unchecked")
	public void putAll(Map m , Object... keys) {
		search((keys.length) , keys).putAll(m);
	}

	public Object remove(Object... keys) {
		return search((keys.length-1) , keys).remove(keys[keys.length-1]);
	}

	public int size(Object... keys) {
		return search((keys.length) , keys).size();
	}
}
