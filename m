Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52542F5333
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976080; cv=none; b=HVBbqkV5IQasGJcVVjrXyTGYAJXnH5hIefMmnh4Y+CaXNS1dom07IbusK3CcsVeDBrNizskhjjUCNIBcH8ksYu1Qh19RDCdjB4Ijt6nx/Zxy/Ze0ur2zP0pk0czZvKFWDhKIf+xJcNovY9r/yqxShzRn+UVEB4D0Mkv8+NfPT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976080; c=relaxed/simple;
	bh=WCQWxOUqUGAUbYn/1lWx01t1IwMR1YQjdMHluI9xz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGUunQ6mH5719+0ZkjVgSi2DFoTL70jvdeLrok9e1J3aVeJdGV3X6v9TS6jIza7YEpYHDgWw3mLBYyUxdMBA0RPZpkeEFWaD/Pdc/ZW4USKt5RZ0b+ifYk6BgQhpTftFHjUxOSIjw1o8YxInMdJQHzC5GKQTKF78TJzlyOrS15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAWuWmGR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAWuWmGR"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso6953624a12.3
        for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763976077; x=1764580877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py5UyMFrH5g95YFUXPVBx4QadWCxP51woz9z/OSNb28=;
        b=kAWuWmGRbGl9VeZyGW8DQrCubd1Y18e68qMDMAWNOwXuNvG+XWnSIHBoEpQt77flUn
         pTzOgZKZ/juU+9RJMfPI6oJFp6VcrrpA2hsMKyo7ILeb6GexD9E8VPOoTsxE0VQmbE8+
         Xf3OC8Q3NqKmjkrI1x9HAK4SzseTbGfNZUrDXnDiL4CUL9kqh4jBUxa+ZlUbHaLSsfXK
         PCaIg5hsrrCpENMC+qiLDENJpLjJWR/aY+/ga6GkinkTCBSL0r6JnTAP19GKKKkkrZRU
         mEePirtk8qFmdIg+AKq4OT6OHblN1f43brca0ojs6NdDwnbH2HmkqW22Wj+9OriLRw2X
         cPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976077; x=1764580877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py5UyMFrH5g95YFUXPVBx4QadWCxP51woz9z/OSNb28=;
        b=Gc6wgkl4gRa5UrnbyEtnfzxAOIFwlq8U0M9KVUIKTauIAnsJPu5FXxpVzHg4TOhEVX
         q0osuLPi+uJex1PEAxFUgKlfGQAi4lP2ZTY4mrxyA4atUEYnTZRt5ZgH1h6rQpfeY9ie
         UagtbiWv3QGA4IpbtfqT4ufwN01J67SN0y7ZgEGzT55KqiWr0DwAXHKrWh3LoyVxCnyX
         A8176W0sGGdZ+AxSgFu+NKAdQCWie2N77GkLlHX6cDtIgZguogmAk4ci5DN4zuelDZI6
         WbY+Pw6xX4+naK7WpqtfsISASnm6S2WG/ixa+SvShLHA0G0Q4KqCadPvsRwGTig/mouW
         1LbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMNTxrTyfm4bJeQpnxtgWCZDG9C3HA2bUMpAA2GVwubM3PwTGjG0EAr4byG35OcXxNylj@lists.linux.dev
X-Gm-Message-State: AOJu0YwH1sEABMlfacNS54Cz5n/SPU31N35oSjp5MtFuDZcA2lWy5yZ1
	W98zDFKQ6hrnagtibjUZnlyv7ByIOBZdcyh+JCWdkyggo4+dg4Uokhpw
X-Gm-Gg: ASbGncuJ1oSi72yPdNkMToTfdO3/aHMAaP9LJqSq0c2/oiGfW7aqTlbES+D81cF9t/Z
	ksHP1unjRBYRH1TnL4sjmErQKO1ErGJWQgVD2zt2T8Xhf+tmpJfJXhFZhsu6UGkvtUoLX0oaaOf
	y8lE0fvoBY8X8A7/HaiI9JiJW4p7ISEorarzPc1JIgt31DQ3kCB2F3ks5P+PD1eHIY2WstVnPq2
	bKgdIEF6BDqGuintEoSua49yDdnOG29a6bFnVfjGBNNR/Jy5tC455JmckucKJ9bsruds06Mjyii
	anA/qTOj3o108QEYaRqKoRm3+tx5ILyFTvtbtDmH9RYOgnTDKYXQIAmcM8zIIcqExfoWzzl8wrW
	9rtGVGk1n65iKSMAgYBxBBwkfibL8rSMPQvjHOYVliWhA4FYoKo64MqiOaaW/WlMXbcl1LgJDEq
	jlapJhlU+QNmFjZ17kee9NF24l3KhYFI7RYQfniqg0k52i+5Hj2hUtc+oG
X-Google-Smtp-Source: AGHT+IEq6wk6IF4PKQSBwW24QSZ4NyUido17WV24VCrnxRb9lAJx3PtZq9pP6MUoSZR1PE+9azUxIA==
X-Received: by 2002:a05:6402:3246:20b0:640:c640:98c5 with SMTP id 4fb4d7f45d1cf-6455469d112mr8161208a12.34.1763976076961;
        Mon, 24 Nov 2025 01:21:16 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b6012sm11432201a12.12.2025.11.24.01.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:21:16 -0800 (PST)
Date: Mon, 24 Nov 2025 10:21:07 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org, neil@brown.name
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <c2kpawomkbvtahjm7y5mposbhckb7wxthi3iqy5yr22ggpucrm@ufvxwy233qxo>
References: <gyt53gbtarw75afmeswazv4dmmj6mc2lzlm2bycunphazisbyq@qrjumrerwox5>
 <6924057f.a70a0220.d98e3.007b.GAE@google.com>
 <wtgy54dfpiapekffjjkonkkhpnxiktfp24wdmwdzf4gslrtact@pongm7vm3l2y>
 <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHfGndcMwXMupOs82HM6c_ajMw8GETxPdkqzORrEq0btA@mail.gmail.com>

On Mon, Nov 24, 2025 at 10:01:53AM +0100, Mateusz Guzik wrote:
> sigh, so it *is* my patch, based on syzbot testing specifically on
> directory locking vs inode branches, but I don't see why.
> 
> I take it the open() codepath took the rwsem, hence the rename is
> sleeping. Given that all reproducers find it *on* cpu, it may be this
> is busy looping for some reason.
> 
> I don't have time to dig more into it right now, so I think it would
> be best to *drop* my patch for the time being. Once I figure it out
> I'll send a v2.
> 

good news, now that I gave up I found it.

insert_inode_locked() is looping indefinitely an inode which is no
longer I_NEW or I_CREATING.

In stock kernel:
                if (unlikely(!inode_unhashed(old))) {
                        iput(old);
                        return -EBUSY;
                }
                iput(old);

it returns an error

with my patch:
               if (isnew) {
                        wait_on_new_inode(old);
                        if (unlikely(!inode_unhashed(old))) {
                                iput(old);
                                return -EBUSY;
                        }
                }
                iput(old);

unhashed status is only ever check if I_NEW was spotted,

which can be false. Afterwards the routine is stuck in endless cycle of
finding the inode and iputting it.

Christian, I think the easiest way out is to add the fix I initially
posted, inlined below. It *was* successfuly tested by syzbot. It retains
inode_unhashed checks even when they are not necessary to avoid any more
surprises.

There were some other changes in the area and turns out sending a v2 for
the patch would result in some merge conflicts, on the other hand the
patch below should be trivial to fold into the existing commit.

Sorry for the spam everyone. :-)

diff --git a/fs/inode.c b/fs/inode.c
index 0f3a56ea8f48..80298f048117 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1311,12 +1311,11 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 		spin_unlock(&inode_hash_lock);
 		if (IS_ERR(old))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(old);
-			if (unlikely(inode_unhashed(old))) {
-				iput(old);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(old))) {
+			iput(old);
+			goto again;
 		}
 		return old;
 	}
@@ -1413,12 +1412,11 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 		return inode;
 	}
@@ -1459,12 +1457,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 		return inode;
 	}
@@ -1501,12 +1498,11 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (IS_ERR(old))
 			return NULL;
 		inode = old;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1648,12 +1644,11 @@ struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 again:
 	inode = ilookup5_nowait(sb, hashval, test, data, &isnew);
 	if (inode) {
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1682,12 +1677,11 @@ struct inode *ilookup(struct super_block *sb, unsigned long ino)
 	if (inode) {
 		if (IS_ERR(inode))
 			return NULL;
-		if (unlikely(isnew)) {
+		if (unlikely(isnew))
 			wait_on_new_inode(inode);
-			if (unlikely(inode_unhashed(inode))) {
-				iput(inode);
-				goto again;
-			}
+		if (unlikely(inode_unhashed(inode))) {
+			iput(inode);
+			goto again;
 		}
 	}
 	return inode;
@@ -1863,12 +1857,11 @@ int insert_inode_locked(struct inode *inode)
 		isnew = !!(inode_state_read(old) & I_NEW);
 		spin_unlock(&old->i_lock);
 		spin_unlock(&inode_hash_lock);
-		if (isnew) {
+		if (isnew)
 			wait_on_new_inode(old);
-			if (unlikely(!inode_unhashed(old))) {
-				iput(old);
-				return -EBUSY;
-			}
+		if (unlikely(!inode_unhashed(old))) {
+			iput(old);
+			return -EBUSY;
 		}
 		iput(old);
 	}
