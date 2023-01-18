package com.moiza.dao;

import java.util.List;

import com.moiza.entity.Authorities;
import com.moiza.entity.ImgEntity;
import com.moiza.entity.LocalEntity;
import com.moiza.entity.MgroupEntity;
import com.moiza.entity.PostEntity;
import com.moiza.entity.UserEntity;
import com.moiza.entity.UsergroupEntity;

public interface MoizaDao {

	int UseridChangeUserindex(String userId);

	List<MgroupEntity> getSubscribedMgroup(int userIndex, String usergroupUserRole);
	
	List<MgroupEntity> bestGroup();
	
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

	List<ImgEntity> getImg();

	void savejoingroup(int userIndex, int mgroupIndex);
	
	List<UserEntity> theUserInformation(String userId);

	void updateUserInfo(int user_index, String user_phone, String password);

	void DeleteUser(String userId);

	List<LocalEntity> getLocal();

	List<MgroupEntity> searchGroup(String searchGroup);
	


}
