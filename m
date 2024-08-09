Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D43167DBD
	for <gfs2@lists.linux.dev>; Fri,  9 Aug 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229107; cv=none; b=KxvuuodaCFdnsyg6VZtqDCIPwMXHJcvZ1oBzFvS4Whnx5y2BW/yEbo+oDi9W46tTprgSIPdUmP0nKtrjrts0jq9SxxDQUWcPVNnKyiQD1r6dqGSDLIHRHG7IEMMiEH5rTvnseXUzQxn3pxaxltts3oSoTE/wzyFSzkuUabDrE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229107; c=relaxed/simple;
	bh=fHAWL+liJK7RUemLt/Svh2h8UMEWyBWVNZVgU9u6a6A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh4vyQJveVzqSPXUtSdpB6SCEXZv/QNs08X1tk+Fuf9/rwgmmhIc2Qv+DsHkILEkaELpIhifJYsQCTy/ILG/RFqV4+hUvAz+PuL/qd5/yaqYeLvIFiV44DNNywkSam4SQ+Xq9BqBqIqU3EY2J78009tAgZUeR/UJKN1PlxS3so4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=W0e9nTZi; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="W0e9nTZi"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3dc16d00ba6so1583065b6e.0
        for <gfs2@lists.linux.dev>; Fri, 09 Aug 2024 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723229104; x=1723833904; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2FDeRCcp9Y/rKgVhAuLqn/dDFHjuK0P8k/Tvh5Gfr4=;
        b=W0e9nTZiQN4b7n/H8APf6OOUchsyhFVVgsMb4AtBfA4jG3YCTl3Tpv8SMw5wFXLx9C
         R77+2qspbS6uTguSdNIyMKK3YW4/2gpSzATWUgo2P+2n/g7+HrMKmpdgxkCaXJhGl9k+
         ZjjDBfdIzpCEIPuArijMICd/7kgWnEuRMi3tFHEUSjq6tmwzaM/pgCG5CS1LBxAoZLfP
         xjCU4fC64Z0Dq494VHNjjsyRauNClNHLW1Rmkg9DuNROx58lc2qHUA3iV1S5cl+togJb
         YAYzdMtUukdSwdif36Xnfp8x0y8A+6uGlb4UrdE72SAW6aNMcDzD3R45L5HC3geOzeL+
         9dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229104; x=1723833904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2FDeRCcp9Y/rKgVhAuLqn/dDFHjuK0P8k/Tvh5Gfr4=;
        b=Z5uvGLR8gB3X2Ben8+HzCOYCYAFQ91O28a+sbNwP9I1OE5d97OloYA42R6Keq3Ssdx
         dZVszDenQUfcI+Xg2hppi5Kmkfkt5AT4w8uY063o7ocX+g2z5dMQre7Gp2wi+cQohPkx
         O598ktu8QMa2/vTxusWRJ/bDSXpAebOyoxMkGhYtxXEvEn/4Fjaqg/AJ/URTjsDcm52U
         Gw0cB09kqJXuTZfxIjVP2ooBaDOj7PeDpg2/GA4UWGwMmTQEhwP/8tpDPTyBbkLUblkp
         VFxS/uixSbm5RlO414unvkPNz3x5UUGqeEE6Lv6UFMC6dLpz09oLtV0X+4O+I1YWHPzh
         0vYA==
X-Forwarded-Encrypted: i=1; AJvYcCWNmxuEEV4c/R1nkFJNNbBIjOnOBFhAKlR8nk+eoYiLAWQ0N4EpdvWEiunQaKkUh8aB49e/xYapYGYn9otrAqbCjWT6mw==
X-Gm-Message-State: AOJu0YyOQhYPsjjEaUZbNVQjvJKTptVgVrMhIPDTyiZHDgHibp7Cuq8a
	g4shUetcpZMjNgqw4HFwEHflk4Q7s/xMRhf78WffUi/PMR3Xkozx8vbLKi8DQIvVBBgUucKQQAI
	O
X-Google-Smtp-Source: AGHT+IFJSfLBdAcQ8zCmPIT0ViO/k/ms1JOvkH9AyPyG9fuJoNWPXZHsX6olwKWSfBmyK+3f2osXZw==
X-Received: by 2002:a05:6358:5288:b0:1aa:d71f:6921 with SMTP id e5c5f4694b2df-1b176edf133mr287241555d.5.1723229104145;
        Fri, 09 Aug 2024 11:45:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca3c0bsm647386d6.60.2024.08.09.11.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:45:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v3 09/16] fanotify: allow to set errno in FAN_DENY permission response
Date: Fri,  9 Aug 2024 14:44:17 -0400
Message-ID: <728fb849cd446e6b9a5b9fb9e9985c7d3bd9896a.1723228772.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723228772.git.josef@toxicpanda.com>
References: <cover.1723228772.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

With FAN_DENY response, user trying to perform the filesystem operation
gets an error with errno set to EPERM.

It is useful for hierarchical storage management (HSM) service to be able
to deny access for reasons more diverse than EPERM, for example EAGAIN,
if HSM could retry the operation later.

Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
to permission events with the response value FAN_DENY_ERRNO(errno),
instead of FAN_DENY to return a custom error.

Limit custom error values to errors expected on read(2)/write(2) and
open(2) of regular files. This list could be extended in the future.
Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
writing a response to an fanotify group fd with a value of FAN_NOFD in
the fd field of the response.

The change in fanotify_response is backward compatible, because errno is
written in the high 8 bits of the 32bit response field and old kernels
reject respose value with high bits set.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 18 ++++++++++-----
 fs/notify/fanotify/fanotify.h      | 10 +++++++++
 fs/notify/fanotify/fanotify_user.c | 36 +++++++++++++++++++++++++-----
 include/linux/fanotify.h           |  5 ++++-
 include/uapi/linux/fanotify.h      |  7 ++++++
 5 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4e8dce39fa8f..1cbf41b34080 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -224,7 +224,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
 				 struct fanotify_perm_event *event,
 				 struct fsnotify_iter_info *iter_info)
 {
-	int ret;
+	int ret, errno;
+	u32 decision;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
@@ -257,20 +258,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
 		goto out;
 	}
 
+	decision = fanotify_get_response_decision(event->response);
 	/* userspace responded, convert to something usable */
-	switch (event->response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
 		ret = 0;
 		break;
 	case FAN_DENY:
+		/* Check custom errno from pre-content events */
+		errno = fanotify_get_response_errno(event->response);
+		if (errno) {
+			ret = -errno;
+			break;
+		}
+		fallthrough;
 	default:
 		ret = -EPERM;
 	}
 
 	/* Check if the response should be audited */
-	if (event->response & FAN_AUDIT)
-		audit_fanotify(event->response & ~FAN_AUDIT,
-			       &event->audit_rule);
+	if (decision & FAN_AUDIT)
+		audit_fanotify(decision & ~FAN_AUDIT, &event->audit_rule);
 
 	pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
 		 group, event, ret);
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 7f06355afa1f..d0722ef13138 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -528,3 +528,13 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 
 	return mflags;
 }
+
+static inline u32 fanotify_get_response_decision(u32 res)
+{
+	return res & (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS);
+}
+
+static inline int fanotify_get_response_errno(int res)
+{
+	return res >> FAN_ERRNO_SHIFT;
+}
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ed56fe6f5ec7..0a37f1c761aa 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -337,11 +337,13 @@ static int process_access_response(struct fsnotify_group *group,
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
 	u32 response = response_struct->response;
+	u32 decision = fanotify_get_response_decision(response);
+	int errno = fanotify_get_response_errno(response);
 	int ret = info_len;
 	struct fanotify_response_info_audit_rule friar;
 
-	pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%zu\n", __func__,
-		 group, fd, response, info, info_len);
+	pr_debug("%s: group=%p fd=%d response=%x errno=%d buf=%p size=%zu\n",
+		 __func__, group, fd, response, errno, info, info_len);
 	/*
 	 * make sure the response is valid, if invalid we do nothing and either
 	 * userspace can send a valid response or we will clean it up after the
@@ -350,18 +352,42 @@ static int process_access_response(struct fsnotify_group *group,
 	if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
 		return -EINVAL;
 
-	switch (response & FANOTIFY_RESPONSE_ACCESS) {
+	switch (decision & FANOTIFY_RESPONSE_ACCESS) {
 	case FAN_ALLOW:
+		if (errno)
+			return -EINVAL;
+		break;
 	case FAN_DENY:
+		/* Custom errno is supported only for pre-content groups */
+		if (errno && group->priority != FSNOTIFY_PRIO_PRE_CONTENT)
+			return -EINVAL;
+
+		/*
+		 * Limit errno to values expected on open(2)/read(2)/write(2)
+		 * of regular files.
+		 */
+		switch (errno) {
+		case 0:
+		case EIO:
+		case EPERM:
+		case EBUSY:
+		case ETXTBSY:
+		case EAGAIN:
+		case ENOSPC:
+		case EDQUOT:
+			break;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
+	if ((decision & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
 		return -EINVAL;
 
-	if (response & FAN_INFO) {
+	if (decision & FAN_INFO) {
 		ret = process_access_response_info(info, info_len, &friar);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index ae6cb2688d52..547514542669 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -132,7 +132,10 @@
 /* These masks check for invalid bits in permission responses. */
 #define FANOTIFY_RESPONSE_ACCESS (FAN_ALLOW | FAN_DENY)
 #define FANOTIFY_RESPONSE_FLAGS (FAN_AUDIT | FAN_INFO)
-#define FANOTIFY_RESPONSE_VALID_MASK (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS)
+#define FANOTIFY_RESPONSE_ERRNO	(FAN_ERRNO_MASK << FAN_ERRNO_SHIFT)
+#define FANOTIFY_RESPONSE_VALID_MASK \
+	(FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS | \
+	 FANOTIFY_RESPONSE_ERRNO)
 
 /* Do not use these old uapi constants internally */
 #undef FAN_ALL_CLASS_BITS
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index cc28dce5f744..7b746c5fcbd8 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -233,6 +233,13 @@ struct fanotify_response_info_audit_rule {
 /* Legit userspace responses to a _PERM event */
 #define FAN_ALLOW	0x01
 #define FAN_DENY	0x02
+/* errno other than EPERM can specified in upper byte of deny response */
+#define FAN_ERRNO_BITS	8
+#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
+#define FAN_ERRNO_MASK	((1 << FAN_ERRNO_BITS) - 1)
+#define FAN_DENY_ERRNO(err) \
+	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
+
 #define FAN_AUDIT	0x10	/* Bitmask to create audit record for result */
 #define FAN_INFO	0x20	/* Bitmask to indicate additional information */
 
-- 
2.43.0

