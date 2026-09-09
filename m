Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7948A8B4
	for <gfs2@lists.linux.dev>; Wed,  9 Sep 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944488; cv=none; b=kbqG6L43l7laDxT8M1ufr78m4voDSzKFbJkUwhkDukni9HNPbTsP/pA0QF1zyJ0+Oujf7Y7vkpRHbaLpno3k0tObqH8y67YsbKhVFTnsTYRzZh0x66Gcjfv6P1Nesdh4JA2mmwBMh63e7dWl2a4W4U8JLyXfoctBrbpu9wmUbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944488; c=relaxed/simple;
	bh=8dP7EXppDq/wK3CzTPpxRisk/j9Ptxr4Q+k72BLzYnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTYVuRD7YCtghFVQqOtB7K1n5UskL+2H8irUMF0x26FXPcsrQKLwFY3/mN00uzrYK/cRTXmZZ4dyc5Aw51iFqX+Mm+q9QY5sGMbBOq80TNqoR2kwQQTF0xy4ZeWM8PKPfLVt4N5PHmvaWzuEcXoPxiqy49V1rcH/Xi7RvwtJNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GgaMtumn; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GgaMtumn"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so5930501a91.2
        for <gfs2@lists.linux.dev>; Wed, 09 Sep 2026 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944480; x=1789549280; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uqYjR8CIvsGBQZ1BYCg5wZAXr0c5gOLef28qhmkr+U=;
        b=GgaMtumnM+LMJi/yblSRG5Pkf2PCQFCpzODYt0DePOZhWyE1JvuXSlOMyMs76qIvIU
         dhxHcpBezFTlHb4S75Diimo9i0CvMNCeJ0ssqKHNRi9m4XhKJDdUUyjNCQbVNaEA+Cm3
         8ntL1j+aQJ31RFprvvugdIPFnp4e6dm6Y90sHSNHpuQH05o9jl2pBQoEGkAl1wiTQY01
         8XB4hnAMwe0Atf6MWrePlrITar8rgxijlcF/4wokc8ri7O3Xp1FzFh0IUGZqoE0mPu3w
         6FOrwPXQBtRJid+PNB7yrEK+5f8ksospcDgaCzWhfJFlNEHrS6IDwp6EXB5U/BfeN3u8
         FQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944480; x=1789549280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uqYjR8CIvsGBQZ1BYCg5wZAXr0c5gOLef28qhmkr+U=;
        b=NiOR2Kr7lEOhwKKxcYbV6wskcQNJBBCOpbgzhTN+mpv7wjIRJRLt8F0JnQAvQnsgFm
         hPlZS0HeTcUtCn5rNy2VIyV/W1LuN7g4ttGggwvvDXFcmspk5Ot2ipKSry7PQRM56UFn
         fRKBXLT1wpH+KiKiY4G/xLXpaeRkFOQs987D/S/gkTtrHd0JTBxa0XXwAqyjCFbEMkwO
         Xtnqlkmmv8GOuoZ25yyX+MeKqCWj8szfOLeeU4e754ttkAxxrvWWb37yEQ3kdtniSGCl
         5xVRgwaV+ACC6b56MijCO4jqTK03PiqRgSbdvRbwDu8HjDSKt2L5t3iVuZ86HA0b6g2N
         /OjA==
X-Forwarded-Encrypted: i=1; AKwUvBzSr1eA64pXo50SYOOE6iLH3QL7ExRZqnEhsSim30TV9phZ+iB5DrMI1DMwSUTlc3utPV0/@lists.linux.dev
X-Gm-Message-State: AFuF++kNkhbZqMCOC3/46wYKPoPvnz1xuo5VyheS66CniL9/jjHid+Oz
	3P3/za/vkYFPlfujkOBwtIv8snd91jFBsVg7Xu1dke03bw2zsM7F7Tz1H2IUfXfCiE4=
X-Gm-Gg: AYBFou21gFCOlw1mhbJ0gCAIRIH3cbJzao5wkZrqP8TYytSWH1pD9O1aK7OwOVANFNh
	9xWj+mbMhIm0PZpvGNoBW7a8J5U2BNLFnNMHG4iWc/RnesB715/la0qSFYsID6Z5tFIDP5/gUsS
	ZSZt7uzXNGGcKYFfzIKxDZUDg2PZtPXnm7inbLBu2F7gHSzYDjOowBqxn7JMrrZK2Elov5+59qh
	Vvbn/Fr7JqKCoug5vY/91WO9A/XzlwEqOuLu8n5DEYeQ/yB1eGhCmsIlHVx2dwuwXwUcQxAVJ3d
	WEYf8NK2w3yfpo4wwPpNkmrTLO49WBG4q3yq1JMYS8tRpU+Pg8BKDO6sMs3MSHa89g6IIfx57F0
	FANVGx7YQ4G2h3eKQJUARHjonMZYi+oTPOPiqVVxSZAU+Laht3bElr9GiahDeZmlT0JTrIIr9YC
	xSfEd+mfKmwV/wfCoq4yvsc3v6u/GZd+1fYvadJnqPJ71AntzbfddzmgjSSXoCBOGMW2viR5phL
	Z0=
X-Received: by 2002:a17:90b:2542:b0:398:9beb:5c17 with SMTP id 98e67ed59e1d1-39b2620a2bfmr47341861a91.18.1788944480190;
        Wed, 09 Sep 2026 02:01:20 -0700 (PDT)
Received: from localhost ([106.38.226.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm31433140a91.15.2026.09.09.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:19 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 1/7] fs: remove trailing whitespace from include/linux/fs.h
Date: Wed,  9 Sep 2026 17:01:06 +0800
Message-Id: <20260909090112.790006-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace before introducing the inode iterator API.
This avoids unrelated whitespace changes from automatic editor cleanup
in the following patches. This also fixes formatting issues in fs.h
reported by scripts/checkpatch.pl.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/linux/fs.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9d1e05e8ae6..09c4db5e9ae0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -296,7 +296,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -306,7 +306,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ *			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -1315,8 +1315,10 @@ struct file *get_file_active(struct file **f);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/*
+ * Page cache limit. The filesystems should put that into their s_maxbytes
+ * limits, otherwise bad things can happen in VM.
+ */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2285,7 +2287,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -2907,7 +2909,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
-- 
2.39.5

