Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389B5789E
	for <gfs2@lists.linux.dev>; Fri, 19 Jan 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699266; cv=none; b=ZBObvRBd5myPJGPIYrVc7gTwsiNLxIKjdPWivSnAu3RxziGavmpIAMtIC5acISLcfFzUHvQF/JCKK+EX/HAVzxkrB5/eWysBOTZ+VvlsnjnTqkC/RoGHilFaLYVCiTnLnkHGkwTtH1HMqbAJ9m7O8fJ65qQVr41tjIyx/+02ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699266; c=relaxed/simple;
	bh=YD3LWVAK/M84/Tn5O0agFQFXidqWEikElGWL9ULxasY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh7vaTEgWtTl12DwsBiujj/KHN3LAGhKHf6DiklK350sdV9ENEOhRmEaUMAqzUN6qHbf9DazuKoCbYF/G9d6vQ3VQycChkAJkQ1Gs6mbdN6bLlK6zbemL/IDAVxpzF7ckL8hT79QhN6hHEA8fGLQmgMoyRMa9AoMXp7wApjrMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HztF66Qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HztF66Qd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705699263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BU6c9v3R3XVfzt/5TRsi/wHSMCKRO4aqONIHHQzqP4M=;
	b=HztF66QdDRdnHQsH1/v7XxI9sbbnUGjN6o5gfUlwOS5rwCTgoM+cd/16XoOeXqaWfF/Kmp
	kKWmSlAKrKYQtPxH5atcHv/O0QMpRdZvyCWJGroOLTNfgttRUj/+6N7dMjGehwvuwBIrdx
	ceq50LGLCJdd2FNvenOdlVc1A1q02eg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-pXhBJ3cXOjy5H3ZCL6Z5sA-1; Fri,
 19 Jan 2024 16:20:58 -0500
X-MC-Unique: pXhBJ3cXOjy5H3ZCL6Z5sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61C331C068F7;
	Fri, 19 Jan 2024 21:20:58 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.226.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BD35A40D1B60;
	Fri, 19 Jan 2024 21:20:57 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/9] gfs2: Fix gfs2_drevalidate NULL pointer dereference
Date: Fri, 19 Jan 2024 22:20:48 +0100
Message-ID: <20240119212056.805617-2-agruenba@redhat.com>
In-Reply-To: <20240119212056.805617-1-agruenba@redhat.com>
References: <20240119212056.805617-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit dd00aaeb3432 added an RCU-safe way of computing d_inode(parent)
to gfs2_drevalidate() to support the LOOKUP_RCU flag, but then failed to
convert one of the instances of d_inode(parent) to its RCU-safe
replacement.  This manifested as a NULL pointer dereference.  Fix that.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: dd00aaeb3432 ("gfs2: Use GL_NOBLOCK flag for non-blocking lookups")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/dentry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/dentry.c b/fs/gfs2/dentry.c
index 177f1f41f225..c6483fb98624 100644
--- a/fs/gfs2/dentry.c
+++ b/fs/gfs2/dentry.c
@@ -72,7 +72,7 @@ static int gfs2_drevalidate(struct dentry *dentry, unsigned int flags)
 			goto out;
 	}
 
-	error = gfs2_dir_check(d_inode(parent), &dentry->d_name, ip);
+	error = gfs2_dir_check(dinode, &dentry->d_name, ip);
 	valid = inode ? !error : (error == -ENOENT);
 
 	if (!had_lock)
-- 
2.43.0

