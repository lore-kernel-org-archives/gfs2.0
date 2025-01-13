Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC33DABF2
	for <gfs2@lists.linux.dev>; Mon, 13 Jan 2025 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760931; cv=none; b=kAW5NAj9OL/YOmA/7olqwQw5cdLg7e74pDQx9buL404/+beCrNLWObVs5L8Z3nZjacgNXJZmG1/O+l7qHRCeXCMpOOr3FOtQKQh40dxzeTNakaZ24USLD7KVMu2skRczXJ8EU3QBieqVJDsEWBDjfs5Wj3ZAuiSjDD9oi3AS/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760931; c=relaxed/simple;
	bh=gY8o1pWtlJC+icfLXG2QcPmT9NfYWMeGj58rsz8sxk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGMD7ps8vDaJK9VykqJ159oz9Cl9sZfcL2QJ+8dd/2cEt6afECZ0kspYnD1lVGxGnqOXD31S98BLvKrBGKMIce8vJOyG9e1rzclXnfhOfDMWLea8Pb2thRUQjUIw38KT6d8Iil5eLFQxbGFRaHWSQNkHd5v3UbP2q6ZGQ++q5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 50D9Z2rc046244;
	Mon, 13 Jan 2025 18:35:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 50D9Z2mr046240
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 13 Jan 2025 18:35:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e346d089-7526-47ea-a64a-b75a578d2362@I-love.SAKURA.ne.jp>
Date: Mon, 13 Jan 2025 18:35:02 +0900
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in __folio_mark_dirty (2)
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>,
        syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>, Wu Fengguang <fengguang.wu@intel.com>,
        Greg Thelen <gthelen@google.com>, gfs2@lists.linux.dev
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
 <20231213-drehen-einquartieren-56bbdda1177e@brauner>
 <CAHc6FU7R+mb3Eh11oOfvDVNg-Zsb-zE9CLEhr4yDKJKU5+ABHA@mail.gmail.com>
 <ebfe4024-f908-458d-9979-6ff2931c460d@I-love.SAKURA.ne.jp>
 <20241203150239.6ibpyziqapxbeenm@quack3>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20241203150239.6ibpyziqapxbeenm@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

While no response from Andreas yet, I found that

diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..90038ec2cfa2 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(const struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
 	WARN_ON_ONCE(debug_locks &&
+		     !sb_is_blkdev_sb(inode->i_sb) &&
 		     (!lockdep_is_held(&inode->i_lock) &&
 		      !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock) &&
 		      !lockdep_is_held(&inode->i_wb->list_lock)));

fixes this problem.

It seems to me that commit 692ebd17c290 ("bdi: Fix warnings in __mark_inode_dirty
for /dev/zero and friends") started special handling for inode_to_bdi(). Thus, I
still suspect that we need some special handling for inode_to_wb() as well. Who is
familiar with differences between normal filesystems and bdev filesystem?

On 2024/12/04 0:02, Jan Kara wrote:
> Hello,
> 
> On Tue 03-12-24 23:44:39, Tetsuo Handa wrote:
>> syzbot is hitting WARN_ON_ONCE() introduced by commit aaa2cacf8184 ("writeback:
>> add lockdep annotation to inode_to_wb()"). Since this warning can be triggered
>> without using crafted/corrupted filesystem image, I assume that either that
>> commit has missed something or gfs2 filesystem is doing something unusual.
>>
>> Steps to reproduce this warning is shown below.
>>
>>   # truncate -s 1G testfile.img
>>   # mkfs.gfs2 -p lock_nolock -t syz:syz testfile.img
>>   # mount -o loop testfile.img /mnt/
>>   # echo test > /mnt/file
>>   # sync
>>
>> This warning goes away if I add "struct address_space *mapping" argument
>> to inode_to_wb() and change the lockdep annotation to check
>> mapping->i_pages.xa_lock instead of inode->i_mapping->i_pages.xa_lock .
>>
>> Also, when this warning happens, inode->i_mapping != mapping is true and
>> it seems that inode->i_mapping points to the same address.
>>
>> Question to start for Tejun is, how did you come to an expectation that
>> we should check inode->i_mapping rather than mapping ?
> 
> Well, mapping->host->i_mapping should better be equal to mapping, or weird
> things happen...  like this one :) But I do have a vague recollection that
> gfs2 breaks this assumption of VFS/MM layers and we've been already
> discussing that in the past. Andreas?
> 
> 									Honza
> 
>>
>> ----------
>> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>> index fcd4c1439cb9..d990a65f3253 100644
>> --- a/mm/page-writeback.c
>> +++ b/mm/page-writeback.c
>> @@ -2721,6 +2721,19 @@ bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
>>  }
>>  EXPORT_SYMBOL(noop_dirty_folio);
>>  
>> +static inline struct bdi_writeback *inode_to_wb2(const struct inode *inode, struct address_space *mapping)
>> +{
>> +#ifdef CONFIG_LOCKDEP
>> +	if (inode->i_mapping != mapping)
>> +		printk("inode=%px inode->i_mapping=%px mapping=%px\n", inode, inode->i_mapping, mapping);
>> +	WARN_ON(debug_locks &&
>> +		(!lockdep_is_held(&inode->i_lock) &&
>> +		 !lockdep_is_held(&mapping->i_pages.xa_lock) && // <= replaced
>> +		 !lockdep_is_held(&inode->i_wb->list_lock)));
>> +#endif
>> +	return inode->i_wb;
>> +}
>> +
>>  /*
>>   * Helper function for set_page_dirty family.
>>   *
>> @@ -2740,7 +2753,7 @@ static void folio_account_dirtied(struct folio *folio,
>>  		long nr = folio_nr_pages(folio);
>>  
>>  		inode_attach_wb(inode, folio);
>> -		wb = inode_to_wb(inode);
>> +		wb = inode_to_wb2(inode, mapping);
>>  
>>  		__lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, nr);
>>  		__zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, nr);
>> @@ -3085,7 +3098,7 @@ bool __folio_end_writeback(struct folio *folio)
>>  		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
>>  					PAGECACHE_TAG_WRITEBACK);
>>  		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
>> -			struct bdi_writeback *wb = inode_to_wb(inode);
>> +			struct bdi_writeback *wb = inode_to_wb2(inode, mapping);
>>  
>>  			wb_stat_mod(wb, WB_WRITEBACK, -nr);
>>  			__wb_writeout_add(wb, nr);
>> @@ -3134,7 +3147,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
>>  
>>  		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
>>  		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
>> -			struct bdi_writeback *wb = inode_to_wb(inode);
>> +			struct bdi_writeback *wb = inode_to_wb2(inode, mapping);
>>  
>>  			wb_stat_mod(wb, WB_WRITEBACK, nr);
>>  			if (!on_wblist)
>>
>> [   85.160317] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50ad73abc0
>> [   85.161923] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621ab0
>> [   85.162644] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
>> [   85.163512] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
>> [   85.164439] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
>> [   85.167314] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f5090621f80
>> [   85.168533] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
>> [   85.169780] inode=ffff9f508f3d8668 inode->i_mapping=ffff9f508f3d8888 mapping=ffff9f50b12c7af0
>>
>>

