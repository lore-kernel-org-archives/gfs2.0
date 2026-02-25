Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348A3859D3
	for <gfs2@lists.linux.dev>; Wed, 25 Feb 2026 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063086; cv=none; b=PMN7lsy4k8HDxlfCjSXQJfP+1vhyW+i2gaELSlmvEqyHJto8LHOBQ4AUsipUd3pXSNo80GFdNG1wKVTz2a8W+HaOIYt82RJNSUxR8EXVRWCVvhEIJxOGRpOsRfCMSmluazM6usGqiwY2KIPlkY4teXT7NpMrK7/EjVqENstyfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063086; c=relaxed/simple;
	bh=86tTrdoOnAn/xo3cekp1XuyRqb4HRFNzoiKbv0I1ps4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bmd45btKR31GI386pj5v71BgKq5inDHxuA7y1nWLK+OxCAXz7wYDHQP9n1w8ZNNjY/tle6y1FpomdXk893rv1R1tR0IeTfFZPaAV3iiFVPFsbxPzqYBq4H/8pZnEM3gw8+qS4V+lBUYWQMIYuI8aebX4z8kzeW8tCh2/rKAQedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=k8p8qfY6; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="k8p8qfY6"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNN6cg2878490
	for <gfs2@lists.linux.dev>; Wed, 25 Feb 2026 18:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=QbU8
	qIjBMGeq/4CCh33jplvuFV4mV/Z7tLyPGzkrhRQ=; b=k8p8qfY6LKJTKzyyIu1T
	MBHAySeSL2rGW18v7FXhhfE5FBzkAnsvzwwdn7GkjnE3GX/FS+1Labq+PlugfXXz
	vOec7glehBd8/aUWG3kwI+2K7MIntwvnNxIlbXeb4MC2Iz8OIYCgGdmmdQomMWcR
	jawfPFhJyFIek32736qXfJ1Zsf8PihQodtpVLS4wPMGxrg7MiHzMTOTAz5tsZHSw
	kZ64SjLH0jiAaG/crVhQ9y25MdtNe8NaKVc7DRq0nHaElnWsMUg1K68u6t5fD41K
	7efzQ1T71c41RoTR8AQXiabnd0+DiFVVEkIL0sRUwP2Sy7x2D3aUqGREmAiKw7yl
	/g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4chnrtr66n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <gfs2@lists.linux.dev>; Wed, 25 Feb 2026 18:44:43 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb37db8b79so258497485a.3
        for <gfs2@lists.linux.dev>; Wed, 25 Feb 2026 15:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063083; x=1772667883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QbU8qIjBMGeq/4CCh33jplvuFV4mV/Z7tLyPGzkrhRQ=;
        b=sYz4sV964x10vTWDHcP+u2uI+/FbhG+pubn6298lk4PpHkWCuEYfAYG6FGILXz2dyl
         h9eDrdkVtciZSnibRoFSQ6ZnQao/PHveUbO0Jh4GHrnZ5otpgBnEAIKiEnHc9MHKZkf6
         HOGhoBXANjXjW3PNsmzV/Lz1ftT6fgPozd5Uokxl+Bw9nSiNGdcoElnSJvdF+UjCSnH2
         XE5iG8HehMWH5zilBm/32C8XeXIpXyfPdAk6Lp+tKsl7IXwqyP9cCJTXJLrVviDMARoN
         3Cbrt1i3GIW9CK35tL9oyS+u+QPZJprd1RrfC5DRclFmgQdNdezCMwXIa00hLPMLI6Um
         qtNg==
X-Forwarded-Encrypted: i=1; AJvYcCVo4zriDRTu2SzW+MEvMqLcpdLezgCcxtiJNNqLXkwrSZGOUKHn+zUswHrbApAa+dFDP+B0@lists.linux.dev
X-Gm-Message-State: AOJu0YxIB1cyRna3jYhE2YLN8p89eIwpztDK/JY81o+bbf+jy/X3XW8G
	L6F0fRp8um8i74XymoFeI5CUNKQ+gA4C4L20F6GjmrkIK2MQbfVW3DObNRyX12txvVuJLkpgDgt
	xeZ0OBIoKrE12mrutvLyAjoKnjDWBpEGIFLCv+4Mo6rM1vBii65s=
X-Gm-Gg: ATEYQzyAeeSkVirTwfln06pC/frWka7xdHp70R6R1SGSJIYb3NNJqMNmV3auJlo0UTn
	kaFoacBDAqTQ2I/HOCkTCF2ZQ8mVhciBmYL0Bee2E4iXI6HyHsz+CQp5SbkAELqyughzRaXrWhg
	mtztRFjs9X8mVRw07S1EiVI1wuxp41Eo/0Jvi+RnjyuDD0iDjU0hdrDITgO7RXjRQZ73XP3tVkf
	hzj+u7HDeNgAddxAEHh9MGqvHcVzBotzsVg2Z6pye8xPhyEIKpBGRNXDWVwjC/DrNJ7aFf0W5pP
	fsRoPffvrThXD6+BbSJ1I29XDnGvYeAqk3JJaxKNoBySpHSGrXr7wAsBVq3gOh3VuNplTx0oyRY
	doj3DbREpueWj1AbLVZopSTnlrLSMTSi8
X-Received: by 2002:a05:620a:bc6:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cbbcf5fcf3mr351656185a.18.1772063082592;
        Wed, 25 Feb 2026 15:44:42 -0800 (PST)
X-Received: by 2002:a05:620a:bc6:b0:8cb:50d6:18be with SMTP id af79cd13be357-8cbbcf5fcf3mr351647085a.18.1772063081985;
        Wed, 25 Feb 2026 15:44:41 -0800 (PST)
Received: from [127.0.1.1] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738d80bsm3357606d6.41.2026.02.25.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:44:41 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Feb 2026 18:44:25 -0500
Subject: [PATCH v2 1/4] mm: Remove stray references to struct pagevec
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-pagevec_cleanup-v2-1-716868cc2d11@columbia.edu>
References: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
In-Reply-To: <20260225-pagevec_cleanup-v2-0-716868cc2d11@columbia.edu>
To: David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Paulo Alcantara <pc@manguebit.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
        Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
        netfs@lists.linux.dev, linux-nfs@vger.kernel.org,
        ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        cgroups@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772063077; l=2123;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=86tTrdoOnAn/xo3cekp1XuyRqb4HRFNzoiKbv0I1ps4=;
 b=0ov9kj7XAzT78Flm+u7++Q86OOmjR2OlGmMBdpiKWPN48FTWijPSg85hjs6TZBPJjXCzDYWnL
 klFYhD+F1AcALAkegHF4EiMet5ndziKuMEd8gAJMsRTj0W6VnFL6fSO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIyNyBTYWx0ZWRfX/QSE8upcVMIG
 Ros2yYz5gJkOZC/rAyprW6efnaKpNY5H6zA4b0iLvH7wRRfRE3Zki8feGD1yINXTm4gooqV1Awq
 wqxv41z6ADXhtlnyO9Qz3CokhlyUDuJ4LHmDcP5IZR1yBhJw3Cl1JuNqZ6lns3aUi4TTCjUPuoE
 8tq6YAxNqKziiY1LL48Fulzu4Hb3fF4tVbo+791a7aZpaZeuG0k2HgXK0p3Tc5c4rV1NDcTZP4n
 bEczmgufi/8yfJwHeam8dHKbB2/jPdfSYKHOTA+98FP2d2Pt9NxCFR8HMCwjww6kdBiF6kR0FTO
 eWk656sbNy9bhSxW56E0UHoB9OsnmYXXIVQ+y96j/0mQkiFtqQ0XrlEZ/+iJxHewZSkUHHscuVq
 WNQTOpF/FvVOfaMZ114W2zqRUELC3sfu0VljRRLuXHyQnuNv4FykDUWeCWO6mJzZdMYEHIYg1OR
 M+RJd3ehUh1+8vbo0pA==
X-Authority-Analysis: v=2.4 cv=bcRmkePB c=1 sm=1 tr=0 ts=699f896b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=KlNbpEHeXbYZISPg4o8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: h588w13xiZm63U8LUdv_xM9MsN1UlOp6
X-Proofpoint-GUID: h588w13xiZm63U8LUdv_xM9MsN1UlOp6
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11712
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=10 bulkscore=10 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 impostorscore=10 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250227

struct pagevec was removed in commit 1e0877d58b1e ("mm: remove struct
pagevec"). Remove remaining forward declarations and change
__folio_batch_release()'s declaration to match its definition.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/afs/internal.h       | 1 -
 fs/f2fs/f2fs.h          | 2 --
 include/linux/pagevec.h | 2 +-
 include/linux/swap.h    | 2 --
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 009064b8d661..599353c33337 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -31,7 +31,6 @@
 
 #define AFS_CELL_MAX_ADDRS 15
 
-struct pagevec;
 struct afs_call;
 struct afs_vnode;
 struct afs_server_probe;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index bb34e864d0ef..d9e8531a5301 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -28,8 +28,6 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 
-struct pagevec;
-
 #ifdef CONFIG_F2FS_CHECK_FS
 #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
 #else
diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 63be5a451627..007affabf335 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -93,7 +93,7 @@ static inline struct folio *folio_batch_next(struct folio_batch *fbatch)
 	return fbatch->folios[fbatch->i++];
 }
 
-void __folio_batch_release(struct folio_batch *pvec);
+void __folio_batch_release(struct folio_batch *fbatch);
 
 static inline void folio_batch_release(struct folio_batch *fbatch)
 {
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0effe3cc50f5..4b1f13b5bbad 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -20,8 +20,6 @@ struct notifier_block;
 
 struct bio;
 
-struct pagevec;
-
 #define SWAP_FLAG_PREFER	0x8000	/* set if swap priority specified */
 #define SWAP_FLAG_PRIO_MASK	0x7fff
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */

-- 
2.39.5

