package com.moiza.dao;

import java.util.List;

import com.moiza.entity.Authorities;
import com.moiza.entity.MgroupEntity;
import com.moiza.entity.PostEntity;
import com.moiza.entity.UserEntity;
import com.moiza.entity.UsergroupEntity;

public interface MoizaDao {

	int UseridChangeUserindex(String userId);

	List<MgroupEntity> getSubscribedMgroup(int userIndex);

	public void saveUser(UserEntity user);

	List<MgroupEntity> getConnectedGroupInfo(int groupIndex);

	List<PostEntity> getConnectedGroupPosts(int groupIndex);

	List<UsergroupEntity> getUserGroup(int userIndex, int mgroupIndex);

	void saveWrittenPost(PostEntity bowOfPost);

	int findMgroupIndexBase(int getUsergroup_index);

	void saveUser1(UserEntity user);

	public void saveAuthority(Authorities authorities);

	public void saveGroup(MgroupEntity mgroup);

	void makeTheLeader(UsergroupEntity usergroupEntity);

}
