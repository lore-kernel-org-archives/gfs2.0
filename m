Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E861741C77
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ4li6v0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703680227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpPM59GW5GTv8TnuY6XzTft5KwJzY3Zyj8FzXrqQWio=;
	b=ZQ4li6v02pKrN3+e6vxOAAI8/CyG3q0xk3s/N1dVTgIW9YqDcwu7o0Sk1iqaWAkYSaklRq
	iz885dq9qVBqB8opwseNl2KZUodfs/0EiHlTUyN1QR1mrT5cPD9PhqL0ey3koFmQ1XjSQp
	d3O6wgh6n8AJCQPsXa4Epqnynu3eCJE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-b2HRvDNKNu2qhDftFoZoQA-1; Wed,
 27 Dec 2023 07:30:26 -0500
X-MC-Unique: b2HRvDNKNu2qhDftFoZoQA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A5D11C0BA4F
	for <gfs2@lists.linux.dev>; Wed, 27 Dec 2023 12:30:26 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8283B492BC6;
	Wed, 27 Dec 2023 12:30:25 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/3] gfs2: Refcounting fix in gfs2_thaw_super
Date: Wed, 27 Dec 2023 13:30:23 +0100
Message-ID: <20231227123024.2698471-2-agruenba@redhat.com>
In-Reply-To: <20231227123024.2698471-1-agruenba@redhat.com>
References: <20231227123024.2698471-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

It turns out that the .freeze_super and .thaw_super operations require
the filesystem to manage the superblock refcount itself.  We are using
the freeze_super() and thaw_super() helpers to mostly take care of that
for us, but this means that the superblock may no longer be around by
when thaw_super() returns, and gfs2_thaw_super() will then access freed
memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6b45b7866212..ae92ae1203d8 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -819,6 +819,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 		return -EINVAL;
 	}
 
+	atomic_inc(&sb->s_active);
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 
 	error = gfs2_do_thaw(sdp);
@@ -828,6 +829,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 		clear_bit(SDF_FROZEN, &sdp->sd_flags);
 	}
 	mutex_unlock(&sdp->sd_freeze_mutex);
+	deactivate_super(sb);
 	return error;
 }
 
-- 
2.43.0

