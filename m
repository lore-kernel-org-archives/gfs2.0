Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A93A8F0
	for <gfs2@lists.linux.dev>; Sat,  5 Oct 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145051; cv=none; b=IF96v9DvOZjYS8bHcKZwEZMaJLV4oK52PTZH+zkNVGyJ7F+C4dExhdUxJr8qSu59hX0+SAaqyf65V6XfnmErfMO7lbh+ssnt60DVtS7phu7oqO3M+QlllZ40Fa84CipqGO/TmS7egqd+PZcDC6eK2ZOoU+RwAQcMQa1nja02iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145051; c=relaxed/simple;
	bh=sHKoS3BN9fpfLGjHRiJ8ZrcURaLtFw0T+ToIiKx8rFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfbfVuU4HW7j+pMkiuaPazUbYOMCNNtwZfvfdyChbjx6wiihf2WIDIbF3Qjt4Se+U+J7JC6KhtBliSNi3eK38BSaBD7WZjFpsbWEYsjnwjONOS2Vb9hjWyYBCbJrFlP/oLcSJxK9PmZ0FZc9JYR22o/l5+DHCSnEwGr6dCbojjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UrTA+Hn2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UrTA+Hn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sPRYKTUuN9x9SJKdTcc6P4AJdIR5+O0ksRXcbg9ijpY=;
	b=UrTA+Hn2G0STLuNCz+V3K5dTG3yWuORr/sn6atCT1EHVsaWOilOGGD1S7wnjsE
	+bba64MYg8F0wfCPb3QaUdm0YchsYNH/V1DJycrRGV8RpCuCDcQxEvBWX+iJDFdu
	VyUHz+/DtHR0to07PfjEqUB08l1QaLNKIpiDJ1dWEP454=
Received: from localhost (unknown [36.5.132.7])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3PyaKZgFn6Ll+BA--.29823S2;
	Sun, 06 Oct 2024 00:17:15 +0800 (CST)
Date: Sun, 6 Oct 2024 00:17:14 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+aa0730b0a42646eb1359@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump (5)
Message-ID: <ZwFmiv0lqP02xPtq@fedora>
References: <66fca31e.050a0220.f28ec.04e4.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fca31e.050a0220.f28ec.04e4.GAE@google.com>
X-CM-TRANSID:_____wD3PyaKZgFn6Ll+BA--.29823S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4REwZcDUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRdvamcBWa5-AQAAs4

#syz test

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6678060ed4d2..d60d53810bc1 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1537,11 +1537,13 @@ static struct inode *gfs2_alloc_inode(struct super_block *sb)
 	if (!ip)
 		return NULL;
 	ip->i_no_addr = 0;
+	ip->i_no_formal_ino = 0;
 	ip->i_flags = 0;
 	ip->i_gl = NULL;
 	gfs2_holder_mark_uninitialized(&ip->i_iopen_gh);
 	memset(&ip->i_res, 0, sizeof(ip->i_res));
 	RB_CLEAR_NODE(&ip->i_res.rs_node);
+	ip->i_diskflags = 0;
 	ip->i_rahead = 0;
 	return &ip->i_inode;
 }

-- 
Best,
Qianqiang Liu

